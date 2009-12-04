require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GenderType do
  before(:each) do
    @valid_attributes = {
      :name => "Female"
    }
    @gender_type = GenderType.new(@valid_attributes)
  end

  it 'should have a name' do
    @gender_type.should respond_to(:name)
    @gender_type.should respond_to(:name=)
  end
  
  it 'should provide the associated patients' do
    GenderType.reflections.keys.should include(:patients)
    GenderType.reflections[:patients].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @gender_type.should be_valid
    end
      
    it 'should require a name' do
      @gender_type.name = nil
      @gender_type.valid?
      @gender_type.should have(1).error_on(:name)
    end
  end
end
