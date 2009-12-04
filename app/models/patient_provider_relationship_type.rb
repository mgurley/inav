class PatientProviderRelationshipType < ActiveRecord::Base
  acts_as_paranoid
  has_many :patient_provider_assignments
  validates_presence_of :name
  validates_inclusion_of :is_allowed_free_text, :in => [true, false]
end
