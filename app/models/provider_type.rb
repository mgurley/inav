class ProviderType < ActiveRecord::Base
  acts_as_paranoid
  has_many :providers
  validates_presence_of :name
end
