class Provider < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  has_many :contact_mechanisms, :as => :contactable, :attributes => true, :dependent => :destroy
  has_many :addresses, :as => :addressable, :attributes => true, :dependent => :destroy
  has_many :patient_provider_assignments
  has_many :patients, :through => :patient_provider_assignments
  belongs_to :provider_type  

  validates_presence_of :first_name, :last_name, :provider_type_id
  validates_associated :contact_mechanisms, :addresses
  validates_uniqueness_of :national_provider_identifier, :message => "can only assign a unique NPI to one Provider", :allow_nil => true, :allow_blank => true
  validates_length_of :national_provider_identifier, :within => 10..10, :allow_nil => true, :allow_blank => true

  named_scope :by_auto_complete, lambda { |search|
    {:limit => 10, :conditions => ['LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR national_provider_identifier LIKE ?', "%#{search.to_s.downcase}%","%#{search.to_s.downcase}%","%#{search}%"]}
  }

  def full_name(options={})
    full_name = []
    full_name << self.first_name
    full_name << self.middle_name unless self.middle_name.blank?
    full_name << self.last_name
    full_name = full_name.join(' ')
    
    if options[:npi]
      full_name +=' NPI: '+ self.national_provider_identifier
    end
    full_name
  end

  def full_name_with_npi
    full_name(:npi=>true)
  end
  
end

