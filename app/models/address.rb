class Address < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  belongs_to :addressable, :polymorphic => true
  belongs_to :address_type
  belongs_to :country
  validates_presence_of :address_line_1, :state_province_name, :postal_code, :country_id, :city, :address_type_id
end