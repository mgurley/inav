module PatientProviderAssignmentsHelper
  def get_patient_provider_relationship_types
    PatientProviderRelationshipType.find(:all, :order=>'name').collect { | a | [a.name, a.id ] }	
  end
end
