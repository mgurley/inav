class GenderType < ActiveRecord::Base
  acts_as_paranoid
  has_many :patients
  validates_presence_of :name
end
