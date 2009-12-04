class PatientProviderAssignment < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  belongs_to :patient
  belongs_to :provider
  belongs_to :patient_provider_relationship_type

  validates_presence_of :patient_id, :provider_id, :patient_provider_relationship_type_id,  :relationship_description

  def validate_on_create
    if (PatientProviderAssignment.count(:conditions => ['patient_id = ? AND provider_id = ? AND deleted_at is null', self.patient_id, self.provider_id]) > 0) then
      errors.add(:provider_id, "can only assign a provider once per patient")
    end
  end

  def defaults()
    patient_provider_relationship_type = PatientProviderRelationshipType.find_by_name("Primary Care Physician")
    self.patient_provider_relationship_type_id = patient_provider_relationship_type.id
    self.relationship_description = patient_provider_relationship_type.name
  end
end
