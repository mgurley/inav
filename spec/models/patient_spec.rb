require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Patient do
  fixtures :gender_types, :patients, :medical_record_number_types , :patient_medical_record_numbers

  before(:each) do
    @valid_attributes =  {
      :first_name => "Bob",
      :last_name => "Jones",
      :middle_name => "Sam",
      :date_of_birth => Date.today,
      :gender_type_id =>  1
    }
    @patient = Patient.new(@valid_attributes)
    @patients = []
  end
  
  it 'should have a first name' do
    @patient.should respond_to(:first_name)
    @patient.should respond_to(:first_name=)
  end

  it 'should have a last name' do
    @patient.should respond_to(:last_name)
    @patient.should respond_to(:last_name=)
  end

  it 'should have a middle name' do
    @patient.should respond_to(:middle_name)
    @patient.should respond_to(:middle_name=)
  end

  it 'should have a date of birth' do
    @patient.should respond_to(:date_of_birth)
    @patient.should respond_to(:date_of_birth=)
  end

  it 'should have a gender' do
    @patient.should respond_to(:gender_type_id)
    @patient.should respond_to(:gender_type_id=)
  end

  it 'should have a note' do
    @patient.should respond_to(:note)
    @patient.should respond_to(:note=)
  end

  
  it 'should have an association to the gender' do
    Patient.reflections.keys.should include(:gender_type)
    Patient.reflections[:gender_type].macro.should == :belongs_to
    Patient.reflections[:gender_type].class_name.should == 'GenderType'
  end

  it 'should provide the associated contact mechanisms' do
    Patient.reflections.keys.should include(:contact_mechanisms)
    Patient.reflections[:contact_mechanisms].macro.should == :has_many
  end

  it 'should provide the associated addresses' do
     Patient.reflections.keys.should include(:addresses)
     Patient.reflections[:addresses].macro.should == :has_many
  end

  it 'should provide the associated patient provider assignments' do
      Patient.reflections.keys.should include(:patient_provider_assignments)
      Patient.reflections[:patient_provider_assignments].macro.should == :has_many
  end

   it 'should provide the associated providers' do
        Patient.reflections.keys.should include(:providers)
        Patient.reflections[:providers].macro.should == :has_many
   end

  it 'should provide the associated medical record numbers' do
    Patient.reflections.keys.should include(:patient_medical_record_numbers)
    Patient.reflections[:patient_medical_record_numbers].macro.should == :has_many
  end

  it 'should provide the associated registrations' do
    Patient.reflections.keys.should include(:registrations)
    Patient.reflections[:registrations].macro.should == :has_many
  end
      
  describe 'validations' do

    it "should be vaild given valid attributes" do
      @patient.should be_valid
    end

    it 'should require a first name' do
      @patient.first_name = nil
      @patient.valid?
      @patient.should have(1).error_on(:first_name)
    end

    it 'should require a last name' do
      @patient.last_name = nil
      @patient.valid?
      @patient.should have(1).error_on(:last_name)
    end

    it 'should require a date of birth' do
      @patient.date_of_birth = nil
      @patient.valid?
      @patient.should have(1).error_on(:date_of_birth)
    end

    it 'should require a gender' do
      @patient.gender_type_id = nil
      @patient.valid?
      @patient.should have(1).error_on(:gender_type_id)
    end

    it "should warn the user if another user exists with the same first name, last name and birth date " do
      @patient = Patient.find(patients(:Bob).id)
      @patient.should eql(patients(:Bob))
      Patient.duplicate?(@patient.attributes).should be_true
    end
  end    

  describe 'validations for associated models' do

    it "should be invalid given an associated invalid contact mechanism" do
      pending "to be implemented"
    end

    it "should be invalid given an associated invalid patient_medical_record_numbers" do
      pending "to be implemented"
    end

    it "should be invalid given an associated invalid address" do
      pending "to be implemented"
    end
  end     
  
  describe "getting a full name" do
    it "should display the patient's full name correctly" do
      @patient.full_name.should == "Bob Sam Jones"
    end
  end

  describe "searching for patients" do

    it "should find Bob Jones and Mary Smith given an empty search paramater" do
     @patients = PatientView.search(1, "","")
     @patients.should have(2).patients
     @patients.collect{|patient| patient.id}.should == [patients(:Bob).id,patients(:Mary).id]
    end

    it "should find only Bob Jones given a search paramater of 'bob'" do
     @patients = PatientView.search(1, "","bob")
     @patients.should have(1).patient
     @patients.collect{|patient| patient.id}.should == [patients(:Bob).id]
    end


    it "should find only Mary Smith given a search paramater of 'smith'" do
     @patients = PatientView.search(1, "","smith")
     @patients.should have(1).patient
     @patients.collect{|patient| patient.id}.should == [patients(:Mary).id]
    end

    it "should find only Mary Smith given a search paramater of '900'" do
     @patients = PatientView.search(1, "","900")
     @patients.should have(1).patient
     @patients.collect{|patient| patient.id}.should == [patients(:Mary).id]
    end

    it "should be sorted by first_name by default" do
     @patients = PatientView.search(1, "","")
     @patients.should have(2).patients
     @patients[0].first_name.should eql("Bob")
    end

    it "should be sorted by first name if requested" do
     @patients = PatientView.search(1, "first_name","")
     @patients.should have(2).patients
     @patients[0].first_name.should eql("Bob")
    end

    it "should be sorted by first name reversed if requested" do
     @patients = PatientView.search(1, "first_name_reverse","")
     @patients.should have(2).patients
     @patients[0].first_name.should eql("Mary")
    end

    it "should be sorted by last name if requested" do
     @patients = PatientView.search(1, "last_name","")
     @patients.should have(2).patients
     @patients[0].last_name.should eql("Jones")
    end

   it "should be sorted by last name reversed if requested" do
     @patients = PatientView.search(1, "last_name_reverse","")
     @patients.should have(2).patients
     @patients[0].last_name.should eql("Smith")
    end

   it "should be sorted by gender if requested" do
    @patients = PatientView.search(1, "gender","")
    @patients.should have(2).patients
    @patients[0].gender_types_name.should eql("female")
   end

   it "should be sorted by gender reversed if requested" do
     @patients = PatientView.search(1, "gender_reverse","")
     @patients.should have(2).patients
     @patients[0].gender_types_name.should eql("male")
   end

   it "should be sorted by date of birth if requested" do
    @patients = PatientView.search(1, "date_of_birth","")
    @patients.should have(2).patients
    @patients[0].date_of_birth.to_s.should eql("1955-10-11")
   end

   it "should be sorted by date of birth reversed if requested" do
     @patients = PatientView.search(1, "date_of_birth_reverse","")
     @patients.should have(2).patients
     @patients[0].date_of_birth.to_s.should eql("1972-10-11")
   end 

  end  
end