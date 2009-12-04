require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientProviderRelationshipType do
  before(:each) do
    @valid_attributes = {
      :name => "Primary Care Physician",
      :is_allowed_free_text => false
    }

    @patient_provider_relationship_type = PatientProviderRelationshipType.new(@valid_attributes)
  end

  it 'should have a name' do
    @patient_provider_relationship_type.should respond_to(:name)
    @patient_provider_relationship_type.should respond_to(:name=)
  end

  it 'should have a allow_free_text' do
    @patient_provider_relationship_type.should respond_to(:is_allowed_free_text)
    @patient_provider_relationship_type.should respond_to(:is_allowed_free_text=)
  end

  it 'should provide the associated patient provider assignments' do
    PatientProviderRelationshipType.reflections.keys.should include(:patient_provider_assignments)
    PatientProviderRelationshipType.reflections[:patient_provider_assignments].macro.should == :has_many
  end


  describe 'validations' do

    it "should be vaild given valid attributes" do
      @patient_provider_relationship_type.should be_valid
    end
      
    it 'should require a name' do
      @patient_provider_relationship_type.name = nil
      @patient_provider_relationship_type.valid?
      @patient_provider_relationship_type.should have(1).error_on(:name)
    end


    it 'should require an allow free text' do
      @patient_provider_relationship_type.is_allowed_free_text = nil
      @patient_provider_relationship_type.valid?
      @patient_provider_relationship_type.should have(1).error_on(:is_allowed_free_text)
    end
  end
end