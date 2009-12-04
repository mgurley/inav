module PatientsHelper
  def get_gender_types
    GenderType.find(:all, :order=>'name').collect { | a | [a.name, a.id ] }
  end
end
