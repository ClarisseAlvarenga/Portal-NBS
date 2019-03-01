class AddNotations < ActiveRecord::Migration
  def change
    create_table :notations do |t|
      t.integer 'concept_id'
      t.string 'value' 
      t.string 'data_type' 
    end
  end
end
