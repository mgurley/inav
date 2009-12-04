class AddPatientProviderRelationshipTypeIdToPatientProviderAssignments < ActiveRecord::Migration
  def self.up    
    add_column(:patient_provider_assignments, :patient_provider_relationship_type_id, :integer, :null => true )
    
    change_column_null(:patient_provider_assignments, :patient_provider_relationship_type_id, true, PatientProviderRelationshipType.find_by_name("Primary Care Physician") )

    execute "ALTER TABLE patient_provider_assignments ADD CONSTRAINT patient_provider_relationship_type_id_fkey FOREIGN KEY (patient_provider_relationship_type_id) REFERENCES patient_provider_relationship_types (id) DEFERRABLE;"
    
  end

  def self.down
    execute "ALTER TABLE patient_provider_assignments DROP CONSTRAINT patient_provider_relationship_type_id_fkey;"    
    remove_column(:patient_provider_assignments, :patient_provider_relationship_type_id)
  end
end
