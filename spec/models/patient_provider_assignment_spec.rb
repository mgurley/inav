require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientProviderAssignment do
  fixtures :gender_types, :patients, :provider_types, :providers, :patient_provider_relationship_types
  before(:each) do
    @valid_attributes = {
      :patient_id => "1",
      :provider_id => "1",
      :relationship_description => "value for description",
      :patient_provider_relationship_type_id => "1"
    }
    @patient_provider_assignment = PatientProviderAssignment.new(@valid_attributes)
  end

  it 'should have a patient_id' do
    @patient_provider_assignment.should respond_to(:patient_id)
    @patient_provider_assignment.should respond_to(:patient_id=)
  end

  it 'should have a provider_id' do
    @patient_provider_assignment.should respond_to(:provider_id)
    @patient_provider_assignment.should respond_to(:provider_id=)
  end


  it 'should have a patient provider relationship type' do
    @patient_provider_assignment.should respond_to(:patient_provider_relationship_type_id)
    @patient_provider_assignment.should respond_to(:patient_provider_relationship_type_id=)
  end


  it 'should have a description' do
    @patient_provider_assignment.should respond_to(:relationship_description)
    @patient_provider_assignment.should respond_to(:relationship_description=)
  end

  it 'should have an association to the patient' do
    PatientProviderAssignment.reflections.keys.should include(:patient)
    PatientProviderAssignment.reflections[:patient].macro.should == :belongs_to
    PatientProviderAssignment.reflections[:patient].class_name.should == 'Patient'
  end

  it 'should have an association to the provider' do
    PatientProviderAssignment.reflections.keys.should include(:provider)
    PatientProviderAssignment.reflections[:provider].macro.should == :belongs_to
    PatientProviderAssignment.reflections[:provider].class_name.should == 'Provider'
  end

  it 'should have an association to the patient provider relationship type' do
    PatientProviderAssignment.reflections.keys.should include(:patient_provider_relationship_type)
    PatientProviderAssignment.reflections[:patient_provider_relationship_type].macro.should == :belongs_to
    PatientProviderAssignment.reflections[:patient_provider_relationship_type].class_name.should == 'PatientProviderRelationshipType'
  end

  describe 'validations' do
  
    it "should be vaild given valid attributes" do
      @patient_provider_assignment.should be_valid
    end
  
    it 'should require a patient' do
      @patient_provider_assignment.patient_id = nil
      @patient_provider_assignment.valid?
      @patient_provider_assignment.should have(1).error_on(:patient_id)
    end

    it 'should require a provider' do
      @patient_provider_assignment.provider_id = nil
      @patient_provider_assignment.valid?
      @patient_provider_assignment.should have(1).error_on(:provider_id)
    end

    it 'should require a patient provider relationship type' do
      @patient_provider_assignment.patient_provider_relationship_type_id = nil
      @patient_provider_assignment.valid?
      @patient_provider_assignment.should have(1).error_on(:patient_provider_relationship_type_id)
    end

    it 'should require a patient provider relationship description' do
      @patient_provider_assignment.relationship_description = nil
      @patient_provider_assignment.valid?
      @patient_provider_assignment.should have(1).error_on(:relationship_description)
    end

  end

  describe "validaitons for uniqueness" do
   before(:each) do
       @patient = Patient.find(patients(:Bob).id)
       @provider = Provider.find(providers(:Doogie).id)
       @attributes = {:patient_id => @patient.id, :provider_id => @provider.id, :patient_provider_relationship_type_id => PatientProviderRelationshipType.find_by_name("Primary Care Physician").id, :relationship_description => "Prinmary Care Physician", :created_by => 'testuser', :created_ip => '0.0.0.0' }
       @patient_provider_assignment_original = PatientProviderAssignment.new(@attributes)       
       @patient_provider_assignment_original.stub!(:notify=>true) # no observers get called
       @patient_provider_assignment_original.save
   end

   it 'should be able to assign a provider only once per patient' do
     patient_provider_assignment = PatientProviderAssignment.new(@attributes)
     patient_provider_assignment.valid?
     patient_provider_assignment.should have(1).error_on(:provider_id)
     patient_provider_assignment.errors.on(:provider_id).to_a.sort.should == ['can only assign a provider once per patient']
   end        

   it 'should be able to assign the same provider to a different patient' do
     patient = Patient.find(patients(:Mary).id)
     @attributes = {:patient_id => patient.id, :provider_id => @provider.id, :patient_provider_relationship_type_id => PatientProviderRelationshipType.find_by_name("Primary Care Physician").id, :relationship_description => "Prinmary Care Physician" }
     patient_provider_assignment = PatientProviderAssignment.new(@attributes)
     patient_provider_assignment.should be_valid
   end        
  end
  
  
  describe "default values" do

   it 'should have a default value of Primary Care Physician for patient provider assignment type' do
     patient_provider_assignment = PatientProviderAssignment.new()
     patient_provider_assignment.defaults       
     patient_provider_assignment.patient_provider_relationship_type_id.should == PatientProviderRelationshipType.find_by_name("Primary Care Physician").id

   end        

  end
end