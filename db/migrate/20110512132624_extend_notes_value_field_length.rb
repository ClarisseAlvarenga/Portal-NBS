class ExtendNotesValueFieldLength < ActiveRecord::Migration
  def self.up
    change_column :notes, :value, :string 
  end

  def self.down
  end
end
