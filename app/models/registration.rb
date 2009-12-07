class Registration < ActiveRecord::Base
  acts_as_paranoid
  simply_versioned
  include PatientStudyCalendar
  belongs_to :patient
  belongs_to :provider, :class_name => "Provider", :foreign_key => "referring_provider_id"
  belongs_to :outcome_type
  validates_presence_of :patient_id, :site_assigned_identifier, :study_assigned_identifier, :study_segment_id, :epoch_name, :study_segment_name, :subject_coordinator_name, :referring_provider_id, :on => :create
  validates_presence_of :outcome_type_id, :inflection_date

  named_scope :by_first_name_last_name, lambda { |search|
    {:include => :patient, :conditions => ["LOWER(patients.first_name) LIKE ? OR LOWER(patients.last_name) LIKE ? OR LOWER(patients.first_name)||' '||LOWER(patients.last_name) LIKE ?", "%#{search.to_s.downcase}%","%#{search.to_s.downcase}%","%#{search.to_s.downcase}%"]}
  }

  def save_with_psc!(patient,options={})
    self.patient_id = patient.id
    self.site_assigned_identifier = PSC_CONFIG[:psc_site]
    self.subject_coordinator_name = options[:subject_coordinator_name].to_s
    self.outcome_type_id = OutcomeType.find_by_name("Open").id
    subject = PatientStudyCalendar::Resources::Subject.new(patient.first_name, patient.last_name, patient.date_of_birth.to_s, patient.id, patient.gender_type.name)
    patient_study_calendar_registration = PatientStudyCalendar::Resources::Registration.new(self.site_assigned_identifier,self.study_assigned_identifier, self.study_segment_id, Date.today.to_s, self.subject_coordinator_name, nil, subject)
    Registration.transaction do
      self.save!
      patient_study_calendar_registration.desired_assignment_id = self.desired_assignment_id
      patient_study_calendar_registration.save!(options)
      self.update_attributes!(:patient_study_calendar_uri =>patient_study_calendar_registration.metadata['location'])
    end
  end

  def registration_assignment_url
    PSC_CONFIG[:psc_canonical_uri] + "pages/subject?assignment=#{CGI.escape(desired_assignment_id)}"
  end

  def scheduled_calendar(cas_pgt)
    unless  @scheduled_calendar
      proxy_ticket = PatientStudyCalendar::Resources::Resource.request_proxy_ticket(cas_pgt)
      study_identifier = study_assigned_identifier
      assignment_identifier = desired_assignment_id
      @scheduled_calendar = PatientStudyCalendar::Resources::ScheduledCalendar.find(study_identifier, assignment_identifier, :proxy_ticket => proxy_ticket)
    end
    @scheduled_calendar
  end

  def active?(cas_pgt)
    scheduled_calendar(cas_pgt).active?
  end

  def last_occured_activity(cas_pgt)
     last_occured_activity = scheduled_calendar(cas_pgt).last_occurred_activity
     last_occured_activity.blank? ? "" : last_occured_activity.to_date.to_s(:date)
  end

  def activites(cas_pgt)
     activites = scheduled_calendar(cas_pgt).scheduled_study_segment.scheduled_activities
     activites.nil? ? [] : activites
  end

  def due_activites(cas_pgt)
     due_activites = scheduled_calendar(cas_pgt).due_activites
     due_activites.nil? ? [] : due_activites
  end


  def overdue_activites(cas_pgt)
     overdue_activites = scheduled_calendar(cas_pgt).overdue_activites
     overdue_activites.nil? ? [] : overdue_activites
  end

  def status(cas_pgt)
    scheduled_calendar(cas_pgt).status
  end

  def desired_assignment_id
    "inav-" + self.id.to_s
  end

  def inflection_interval
    unless (outcome_date.nil? or inflection_date.nil?)
      (outcome_date - inflection_date).to_i
    end
  end

  def registration_interval
    unless (outcome_date.nil? or created_at.nil?)
      (outcome_date - created_at.to_date).to_i
    end
  end

  def self.search(page, sort, status, patients, username, search)
    sort = case sort
           when "first_name"  then "patients.first_name"
           when "first_name_reverse"  then "patients.first_name DESC"
           when "last_name"  then "patients.last_name"
           when "last_name_reverse"  then "patients.last_name DESC"
           when "gender_type_name"  then "gender_types.name"
           when "gender_type_name"  then "gender_types.name DESC"
           when "study_assigned_identifier"  then "registrations.study_assigned_identifier"
           when "study_assigned_identifier_reverse"  then "registrations.study_assigned_identifier DESC"
           when "study_segment_name"  then "registrations.study_segment_name"
           when "study_segment_name_reverse"  then "registrations.study_segment_name DESC"
           when "inflection_date"  then "registrations.inflection_date"
           when "inflection_date_reverse"  then "registrations.inflection_date DESC"
           when "registration_date"  then "registrations.created_at"
           when "registration_date_reverse"  then "registrations.created_at DESC"
           when "outcome_type_name"  then "outcome_types.name"
           when "outcome_type_name_reverse"  then "outcome_types.name DESC"
           when "outcome_date"  then "registrations.outcome_date"
           when "outcome_date_reverse"  then "registrations.outcome_date DESC"
           when "subject_coordinator_name"  then "registrations.subject_coordinator_name"
           when "subject_coordinator_name_reverse"  then "registrations.subject_coordinator_name DESC"
           else "patients.last_name"
           end

    conditions = case patients
      when "mine"  then  {:subject_coordinator_name => username}
      when "all"   then  {}
      else               {:subject_coordinator_name => username}
      end

    outcome_types = case status
      when "active"     then  OutcomeType.find(:all, :conditions => ["name = 'Open'"]).each {|outcome_type| outcome_type.id}
      when "inactive"   then  OutcomeType.find(:all, :conditions => ["name != 'Open'"]).each {|outcome_type| outcome_type.id}
      when "all"        then  OutcomeType.find(:all).each {|outcome_type| outcome_type.id}
      else                    OutcomeType.find(:all, :conditions => ["name = 'Open'"]).each {|outcome_type| outcome_type.id}
      end

    conditions.merge!({:outcome_type_id => outcome_types})

    registrations = Registration.by_first_name_last_name(search).find(:all,:conditions => conditions, :order => sort, :include => [{:patient =>:gender_type}, :outcome_type])

    registrations = registrations.paginate(:page => page, :per_page => 10)

  end

  def validate
    unless self.outcome_date.nil?
      errors.add("outcome_date", "cannot be before Inflection Date") if self.outcome_date < self.inflection_date
      errors.add("outcome_date", "cannot be before Registration Date") if self.outcome_date < self.created_at.to_date
    end
  end
end