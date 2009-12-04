class AddressType < ActiveRecord::Base
  acts_as_paranoid
  has_many :addresses
  validates_presence_of :name
end
