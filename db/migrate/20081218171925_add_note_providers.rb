class AddNoteProviders < ActiveRecord::Migration
  def self.up
    add_column(:providers, :note, :text, :null => true )

  end

  def self.down
    remove_column(:providers, :note)
  end
end

