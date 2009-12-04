require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactMechanism do
  fixtures :gender_types, :patients, :contact_mechanism_types, :contact_mechanisms, :medical_record_number_types , :patient_medical_record_numbers
  before(:each) do
    @valid_attributes = {
      :contact_mechanism_code => "312 999 2222",
      :contact_mechanism_type_id => "1",
      :contactable_type => "Patient",
      :contactable_id => "1"
    }
    @contact_mechanism = ContactMechanism.new(@valid_attributes)
  end

  it 'should have a contact_mechanism_type_id' do
    @contact_mechanism.should respond_to(:contact_mechanism_code)
    @contact_mechanism.should respond_to(:contact_mechanism_code=)
  end

  it 'should have a contact_mechanism_type_id' do
    @contact_mechanism.should respond_to(:contact_mechanism_type_id)
    @contact_mechanism.should respond_to(:contact_mechanism_type_id=)
  end

  it 'should have a contactable_type' do
    @contact_mechanism.should respond_to(:contactable_type)
    @contact_mechanism.should respond_to(:contactable_type=)
  end

  it 'should have a contactable_id' do
    @contact_mechanism.should respond_to(:contactable_id)
    @contact_mechanism.should respond_to(:contactable_id=)
  end

  it 'should have an association to the contactable' do
    ContactMechanism.reflections.keys.should include(:contactable)
    ContactMechanism.reflections[:contactable].macro.should == :belongs_to
    ContactMechanism.reflections[:contactable].class_name.should == 'Contactable'
  end

  it 'should have an association to the contact mechanism type' do
    ContactMechanism.reflections.keys.should include(:contact_mechanism_type)
    ContactMechanism.reflections[:contact_mechanism_type].macro.should == :belongs_to
    ContactMechanism.reflections[:contact_mechanism_type].class_name.should == 'ContactMechanismType'
  end


    describe 'validations' do

      it "should be vaild given valid attributes" do
        @contact_mechanism.should be_valid
      end

      it 'should require a contact_mechanism_code' do
        @contact_mechanism.contact_mechanism_code = nil
        @contact_mechanism.valid?
        @contact_mechanism.should have(1).error_on(:contact_mechanism_code)
      end

      it 'should require a contact_mechanism_type_id' do
        @contact_mechanism.contact_mechanism_type_id = nil
        @contact_mechanism.valid?
        @contact_mechanism.should have(1).error_on(:contact_mechanism_type_id)
      end

    end
  end