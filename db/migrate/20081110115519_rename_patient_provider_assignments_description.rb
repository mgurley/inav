class RenamePatientProviderAssignmentsDescription < ActiveRecord::Migration
  def self.up
    rename_column(:patient_provider_assignments, :description, :relationship_description)    
  end

  def self.down
    rename_column(:patient_provider_assignments, :relationship_description, :description)    
  end
end
