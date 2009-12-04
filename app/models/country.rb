class Country < ActiveRecord::Base
  acts_as_paranoid
  has_many :addresses
  has_many :state_provinces
  validates_presence_of :name, :code
end
