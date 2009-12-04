class RegistrationsController < ApplicationController
  before_filter :find_patient, :except => [:index, :show, :change_study]
  before_filter :find_registration, :only => [:edit, :update, :destroy]

  # GET /registrations
  # GET /registrations.xml
  def index
    @registrations = Registration.search(params[:page], params['sort'], params['status'],  params['patients'], session[:cas_user], params['search'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.xml
  def show
    params[:id].to_s =~/\d+/
    id = $&
    @registration = Registration.find(id)
    redirect_to(@registration.patient)
  end

  # GET /registrations/new
  # GET /registrations/new.xml
  def new
    @registration = Registration.new()
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  # POST /registrations.xml
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      begin
        proxy_ticket = PatientStudyCalendar::Resources::Resource.request_proxy_ticket(session[:cas_pgt])
        @registration.save_with_psc!(@patient, :subject_coordinator_name => session[:cas_user], :proxy_ticket => proxy_ticket)
        flash[:notice] = 'Registration was successfully created.'
        format.html { redirect_to(@registration.registration_assignment_url) }
        format.xml  { render :xml => @registration, :status => :created, :location => patient_url(@patient) }
      rescue Exception => e
        unless @registration.new_record?
          @registration = Registration.new()
        end
        @registration.errors.add(:id, "There was a problem communicating to the Patient Study Calendar Application.")
        RAILS_DEFAULT_LOGGER.error("Registration create failed: #{e}")
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
       end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.xml
  def update
    respond_to do |format|
      if @registration.update_attributes(params[:registration].only('outcome_type_id','outcome','inflection_date','outcome_date'))
        flash[:notice] = 'Registration was successfully updated.'
        format.html { redirect_to([@patient]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.xml
  def destroy
    flash[:error] = 'Deleting registrations is not supported.'
    respond_to do |format|
      format.html { redirect_to([@patient]) }
      format.xml  { render :xml => @registration.errors.add_to_base(flash[:error]), :status => :unprocessable_entity }
    end
  end

  def change_study
    return unless request.xhr?
      study_assigned_identifer = params[:study_assigned_identifier]
      proxy_ticket = PatientStudyCalendar::Resources::Resource.request_proxy_ticket(session[:cas_pgt])
      study = PatientStudyCalendar::Resources::Study.find(study_assigned_identifer,:proxy_ticket => proxy_ticket)
      study_segments = study.epoch_study_segments
      render :update do |page|
      page << update_select_box( "registration_study_segment_id",
      study_segments,
      {:text => :name,
       :value => :id,
       :include_blank => true}
      )
    end
  end

  private

  def find_patient
    @patient = Patient.find(params[:patient_id])
  end

  def find_registration
    @registration = Registration.find(params[:id])
  end
end