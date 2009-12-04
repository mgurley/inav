class ContactMechanismType < ActiveRecord::Base
  acts_as_paranoid
  has_many :contact_mechanisms
  validates_presence_of :name
end
