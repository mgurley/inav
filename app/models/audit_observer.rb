class AuditObserver < ActiveRecord::Observer
  include UserSessionInfo
  observe :patient, :provider, :address, :contact_mechanism, :patient_medical_record_number, :patient_provider_assignment, :registration

  def before_create(record)
   record.created_by = current_session_user
   record.created_ip = current_session_ip
  end

  def before_update(record)
    record.updated_by = current_session_user
    record.updated_ip = current_session_ip
  end

  def before_destroy(record)
    record.deleted_by = current_session_user
    record.deleted_ip = current_session_ip
    record.save!
  end
end