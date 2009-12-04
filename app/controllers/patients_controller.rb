class PatientsController < ApplicationController
  helper :addresses
  before_filter :find_patient, :only => [:show, :edit, :update, :destroy]
  before_filter :patient_referrer_url, :only =>[:show, :new, :edit]
  skip_before_filter :clear_duplicate_patient, :only =>[:create]

  # GET /patients
  # GET /patients.xml
  def index
    respond_to do |format|
      format.html {@patients = PatientView.search(params[:page], params['sort'], params['search'])}
      format.xml  {@patients = PatientView.find(:all); render :xml => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.xml
  def create
    @patient = Patient.new(params[:patient])

    respond_to do |format|
      if ignore_duplicate_patient?(@patient.attributes) and @patient.save
        session[:duplicate_patient] = {}
        flash[:notice] = 'Patient was successfully created.'
        format.html { redirect_to(@patient) }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    params[:patient][:contact_mechanism_attributes] ||= {}
    params[:patient][:patient_medical_record_number_attributes] ||= {}
    params[:patient][:address_attributes] ||= {}
    @patient.attributes = params[:patient]

    respond_to do |format|
      if @patient.save
        flash[:notice] = 'Patient was successfully updated.'
        format.html { redirect_to(@patient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    flash[:error] = 'Deleting patients is not supported.'
    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { render :xml => @patient.errors.add_to_base(flash[:error]), :status => :unprocessable_entity }
    end
  end

  private

  def find_patient
    @patient = Patient.find(params[:id])
  end

  def patient_referrer_url
    session[:patient_referrer_url] = request.env["HTTP_REFERER"] unless request.env["HTTP_REFERER"] == "#{request.protocol}#{request.host_with_port}#{request.request_uri}"
  end

  def ignore_duplicate_patient?(patient_attributes = {})
    duplicate_patient = {}
    duplicate_patient['first_name'] = patient_attributes['first_name']
    duplicate_patient['last_name'] = patient_attributes['last_name']
    duplicate_patient['created_at'] = patient_attributes['created_at']
    if Patient.duplicate?(patient_attributes) then
      if duplicate_patient == session[:duplicate_patient]
        true
      else
        session[:duplicate_patient] = duplicate_patient
        flash.now[:notice] = 'Duplicate Patient: A patient already exists with this First Name, Last Name and Birth date?  Are you sure?'
        false
      end
    else
      true
    end
  end
end