class PatientMedicalRecordNumber < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  belongs_to :patient
  belongs_to :medical_record_number_type
  validates_presence_of :medical_record_number, :medical_record_number_type_id
  validates_uniqueness_of :medical_record_number, :scope => :medical_record_number_type_id, :message => "can only assign a MRN once per MRN type"
end
