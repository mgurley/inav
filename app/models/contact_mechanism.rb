class ContactMechanism < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  belongs_to :contactable, :polymorphic => true
  belongs_to :contact_mechanism_type
  validates_presence_of :contact_mechanism_code, :contact_mechanism_type_id
end
