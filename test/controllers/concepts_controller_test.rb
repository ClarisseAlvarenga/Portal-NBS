# encoding: UTF-8

# Copyright 2011-2014 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class ConceptsControllerTest < ActionController::TestCase
  require 'authlogic/test_case'

  setup do
    activate_authlogic

    @admin = User.create! do |u|
      u.forename = 'Test'
      u.surname = 'User'
      u.email = 'testuser@iqvoc.local'
      u.password = 'omgomgomg'
      u.password_confirmation = 'omgomgomg'
      u.role = 'administrator'
      u.active = true
    end

    @air_sports = Concept::SKOS::Base.new.tap do |c|
      Iqvoc::RDFAPI.devour c, 'skos:prefLabel', '"Air sports"@en'
      c.publish
      c.save
    end

    @achievement_hobbies = Concept::SKOS::Base.new(top_term: true).tap do |c|
      Iqvoc::RDFAPI.devour c, 'skos:prefLabel', '"Achievement hobbies"@en'
      Iqvoc::RDFAPI.devour c, 'skos:narrower', @air_sports
      c.publish
      c.save
    end

    @sports = Concept::SKOS::Base.new(top_term: true).tap do |c|
      Iqvoc::RDFAPI.devour c, 'skos:prefLabel', '"Sports"@en'
      c.publish
      c.save
    end

  end

  test 'unauthorized node movement request' do
    patch :move,
          lang: 'en',
          origin: @air_sports.origin,
          tree_action: 'move',
          moved_node_id: @air_sports.id,
          old_parent_node_id: @achievement_hobbies.id,
          new_parent_node_id: @sports.id
    assert_response 401
  end

  test 'bad node movement request' do
    patch :move, lang: 'en', origin: @air_sports.origin
    assert_response 400
  end

  test 'concept movement' do
    UserSession.create(@admin)

    assert_equal 1, @achievement_hobbies.narrower_relations.size
    assert_equal 0, @sports.narrower_relations.size
    assert_equal @air_sports.id, @achievement_hobbies.narrower_relations.first.target.id

    # move air_sports from achievement hobbies => sports
    patch :move,
          lang: 'en',
          origin: @air_sports.origin,
          tree_action: 'move',
          moved_node_id: @air_sports.id,
          old_parent_node_id: @achievement_hobbies.id,
          new_parent_node_id: @sports.id
    assert_response 200

    # test newly created air_sports draft concept (not published yet)
    # FIXME: last concept should be the new draft
    @air_sports_draft_concept = Iqvoc::Concept.base_class.last

    assert_equal @air_sports_draft_concept.rev, 2
    assert_equal @air_sports_draft_concept.published_version_id, @air_sports.id
    assert_equal 1, @air_sports_draft_concept.broader_relations.size
    refute @air_sports_draft_concept.published?
  end
end
