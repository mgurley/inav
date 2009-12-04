class AddDataPatientProviderRelationshipTypes < ActiveRecord::Migration
  def self.up
    down
    patient_provider_relationship_type = PatientProviderRelationshipType.create(:name =>"Primary Care Physician", :is_allowed_free_text => false, :created_by => 'system', :created_ip => '0.0.0.0')
    
    patient_provider_relationship_type.save!
     
    patient_provider_relationship_type = PatientProviderRelationshipType.create(:name =>"Specialist", :is_allowed_free_text => true, :created_by => 'system', :created_ip => '0.0.0.0')
    
    patient_provider_relationship_type.save!

    patient_provider_relationship_type = PatientProviderRelationshipType.create(:name =>"Other", :is_allowed_free_text => true, :created_by => 'system', :created_ip => '0.0.0.0')
    
    patient_provider_relationship_type.save!

  end

  def self.down
    execute "DELETE FROM patient_provider_relationship_types;"
  end
end
