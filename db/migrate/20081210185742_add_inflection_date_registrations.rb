class AddInflectionDateRegistrations < ActiveRecord::Migration
  def self.up
      add_column(:registrations, :inflection_date, :datetime, :null => true )

      change_column_null(:registrations, :inflection_date, false, Date.today )

  end

  def self.down
      remove_column(:registrations, :inflection_date)
  end
end