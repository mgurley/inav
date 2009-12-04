class AlterRegistrations < ActiveRecord::Migration
  def self.up
    rename_column(:registrations, :epoch_study_segment_name , :study_segment_name)
    add_column(:registrations, :epoch_name, :string, :null => false)
    add_column(:registrations, :subject_coordinator_name, :string, :null => false)
    add_column(:registrations, :patient_study_calendar_uri, :string)
  end

  def self.down
    rename_column(:registrations, :study_segment_name, :epoch_study_segment_name)
    remove_column(:registrations, :epoch_name)
    remove_column(:registrations, :subject_coordinator_name)
    remove_column(:registrations, :patient_study_calendar_uri)    
  end
end




