class PatientProviderAssignmentsController < ApplicationController
  before_filter :find_patient, :except => [:index, :show]
  before_filter :find_patient_provider_assignment, :only => [:edit, :update, :destroy]

private
  def find_patient
    @patient = Patient.find(params[:patient_id])
  end

  def find_patient_provider_assignment
    @patient_provider_assignment = PatientProviderAssignment.find(params[:id])
  end

public
  # GET /patient_provider_assignments
  # GET /patient_provider_assignments.xml
  def index
    #Nested resources only displayed in the context of its parent patient
    redirect_to(home_url)
  end

  # GET /patient_provider_assignments/1
  # GET /patient_provider_assignments/1.xml
  def show
    #These are nested resources that are only displayed in the context of their parent patient
    redirect_to(home_url)
  end

  # GET /patient_provider_assignments/new
  # GET /patient_provider_assignments/new.xml
  def new
    @patient_provider_assignment = PatientProviderAssignment.new()
    @patient_provider_assignment.defaults

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient_provider_assignment }
    end
  end

  # GET /patient_provider_assignments/1/edit
  def edit
  end

  # POST /patient_provider_assignments
  # POST /patient_provider_assignments.xml
  def create
    @patient_provider_assignment = PatientProviderAssignment.new(params[:patient_provider_assignment])
    @patient_provider_assignment.patient_id = @patient.id

    respond_to do |format|
      if @patient_provider_assignment.save
        flash[:notice] = 'PatientProviderAssignment was successfully created.'
        format.html { redirect_to(@patient) }
        format.xml  { render :xml => @patient_provider_assignment, :status => :created, :location => @patient_provider_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient_provider_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patient_provider_assignments/1
  # PUT /patient_provider_assignments/1.xml
  def update
    respond_to do |format|
      if @patient_provider_assignment.update_attributes(params[:patient_provider_assignment])
        flash[:notice] = 'PatientProviderAssignment was successfully updated.'
        format.html { redirect_to(@patient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient_provider_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_provider_assignments/1
  # DELETE /patient_provider_assignments/1.xml
  def destroy
    @patient_provider_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(patient_url(@patient)) }
      format.xml  { head :ok }
    end
  end
end