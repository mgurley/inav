class MedicalRecordNumberType < ActiveRecord::Base
  acts_as_paranoid
  has_many :patient_medical_record_numbers
  validates_presence_of :name
end
