class ChangeRegistrationsOutcomeDateToDate < ActiveRecord::Migration
  def self.up
    change_column(:registrations, :outcome_date, :date)
  end

  def self.down
  end
end
