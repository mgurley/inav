class OutcomeType < ActiveRecord::Base
  acts_as_paranoid
  has_many :registrations
  validates_presence_of :name
end
