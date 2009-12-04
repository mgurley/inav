class Patient < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  has_many :contact_mechanisms, :as => :contactable, :attributes => true, :dependent => :destroy
  has_many :addresses, :as => :addressable, :attributes => true, :dependent => :destroy
  has_many :patient_medical_record_numbers, :attributes => true, :dependent => :destroy
  has_many :patient_provider_assignments
  has_many :providers, :through => :patient_provider_assignments
  has_many :registrations, :order => "study_assigned_identifier DESC, epoch_name DESC, study_segment_name DESC" 
  belongs_to :gender_type


  validates_presence_of :first_name, :last_name, :date_of_birth
  validates_presence_of :gender_type_id
  validates_associated :contact_mechanisms, :patient_medical_record_numbers, :addresses
  
  def self.duplicate?(patient_attributes={})
    Patient.count(:conditions => ['LOWER(first_name) = ? AND LOWER(last_name) = ? AND date_of_birth = ?', patient_attributes['first_name'].downcase, patient_attributes['last_name'].downcase, patient_attributes['date_of_birth']]) > 0
  end

  def full_name(options={})
    full_name = []
    full_name << self.first_name
    full_name << self.middle_name unless self.middle_name.blank?
    full_name << self.last_name
    full_name = full_name.join(' ')
    
    full_name
  end

  def age
    (Date.today - date_of_birth).to_i / 365
  end

  def before_destroy
     unless self.registrations.empty?
       self.errors.add_to_base "Can't destroy a patient with a registration."
       false
     end
  end
end
