require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientMedicalRecordNumber do
  fixtures :gender_types, :patients, :medical_record_number_types
  before(:each) do
    @valid_attributes = {
      :patient_id => "1",
      :medical_record_number => "123456789",
      :medical_record_number_type_id => "1"
    }
    @patient_medical_record_number = PatientMedicalRecordNumber.new(@valid_attributes)
  end
  
  it 'should have a patient_id' do
    @patient_medical_record_number.should respond_to(:patient_id)
    @patient_medical_record_number.should respond_to(:patient_id=)
  end


  it 'should have a medical_record_number' do
    @patient_medical_record_number.should respond_to(:medical_record_number)
    @patient_medical_record_number.should respond_to(:medical_record_number=)
  end

  it 'should have a medical_record_number_type_id' do
    @patient_medical_record_number.should respond_to(:medical_record_number_type_id)
    @patient_medical_record_number.should respond_to(:medical_record_number_type_id=)
  end

  it 'should have an association to the patient' do
    PatientMedicalRecordNumber.reflections.keys.should include(:patient)
    PatientMedicalRecordNumber.reflections[:patient].macro.should == :belongs_to
    PatientMedicalRecordNumber.reflections[:patient].class_name.should == 'Patient'
  end

  it 'should have an association to a medical record number type' do
    PatientMedicalRecordNumber.reflections.keys.should include(:medical_record_number_type)
    PatientMedicalRecordNumber.reflections[:medical_record_number_type].macro.should == :belongs_to
    PatientMedicalRecordNumber.reflections[:medical_record_number_type].class_name.should == 'MedicalRecordNumberType'
  end


  describe 'validations' do

    it "should be vaild given valid attributes" do
      @patient_medical_record_number.should be_valid
    end

    it 'should require a first name' do
      @patient_medical_record_number.medical_record_number = nil
      @patient_medical_record_number.valid?
      @patient_medical_record_number.should have(1).error_on(:medical_record_number)
    end

    it 'should require a medical record number type' do
      @patient_medical_record_number.medical_record_number_type_id = nil
      @patient_medical_record_number.valid?
      @patient_medical_record_number.should have(1).error_on(:medical_record_number_type_id)
    end
  end  
  
  describe "validaitons for uniqueness" do
   before(:each) do
       @patient = Patient.find(patients(:Bob).id)
       @medical_record_number_type_nmh = MedicalRecordNumberType.find(medical_record_number_types(:NMH).id)
       @medical_record_number_type_nmff = MedicalRecordNumberType.find(medical_record_number_types(:NMFF).id)
       @attributes = {:patient_id => @patient.id, :medical_record_number => "123456789",:medical_record_number_type_id => @medical_record_number_type_nmh.id,:created_by => 'testuser', :created_ip => '0.0.0.0'}
       @patient_medical_record_number_original = PatientMedicalRecordNumber.new(@attributes)       
       @patient_medical_record_number_original.stub!(:notify=>true) # no observers get called
       @patient_medical_record_number_original.save
   end
     
   it 'should be able to assign a MRN only once per MRN type per patient' do
     patient_medical_record_number = PatientMedicalRecordNumber.new(@attributes)
     patient_medical_record_number.valid?
     patient_medical_record_number.should have(1).error_on(:medical_record_number)
   end        
  
   it 'should be able to assign the same MRN for different MRN types' do
     patient_medical_record_number = PatientMedicalRecordNumber.new(@attributes.merge(:medical_record_number_type_id => @medical_record_number_type_nmff.id))
     patient_medical_record_number.should be_valid
   end
  end
end