module RegistrationsHelper
  def get_studies
    proxy_ticket = PatientStudyCalendar::Resources::Resource.request_proxy_ticket(session[:cas_pgt])
    PatientStudyCalendar::Resources::Study.find(:all, :proxy_ticket => proxy_ticket).collect { | s | [s.assigned_identifier, s.assigned_identifier ] }
  end

  def get_providers_for_patient(patient_id)
    PatientProviderAssignment.find(:all, :conditions => ['patient_id= ?', patient_id]).collect { | a | [a.provider.first_name + ' ' + a.provider.last_name, a.provider.id ] }
  end

  def get_outcome_types
    OutcomeType.find(:all, :order=>'name').collect { | a | [a.name, a.id ] }
  end
end
