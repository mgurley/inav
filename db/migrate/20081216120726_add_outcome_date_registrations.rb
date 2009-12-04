class AddOutcomeDateRegistrations < ActiveRecord::Migration
  def self.up
    add_column(:registrations, :outcome_date, :datetime, :null => true )
  end

  def self.down
    remove_column(:registrations, :outcome_date)
  end
end
