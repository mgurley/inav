require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MedicalRecordNumberType do
  before(:each) do
    @valid_attributes = {
      :name => "NMH"
    }
    @medical_record_number_type = MedicalRecordNumberType.new(@valid_attributes)
  end

  it 'should have a name' do
    @medical_record_number_type.should respond_to(:name)
    @medical_record_number_type.should respond_to(:name=)
  end
  
  it 'should provide the associated patient_medical_record_numbers' do
    MedicalRecordNumberType.reflections.keys.should include(:patient_medical_record_numbers)
    MedicalRecordNumberType.reflections[:patient_medical_record_numbers].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @medical_record_number_type.should be_valid
    end
      
    it 'should require a name' do
      @medical_record_number_type.name = nil
      @medical_record_number_type.valid?
      @medical_record_number_type.should have(1).error_on(:name)
    end
  end
end