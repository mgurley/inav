class AddNotePatients < ActiveRecord::Migration
  def self.up
    add_column(:patients, :note, :text, :null => true )

  end

  def self.down
    remove_column(:patients, :note)
  end
end

