class StateProvince < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :country
  validates_presence_of :name, :code
end
