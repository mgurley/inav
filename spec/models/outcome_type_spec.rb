require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutcomeType do
  before(:each) do
    @valid_attributes = {
      :name => "Completed"
    }
    @outcome_type = OutcomeType.new(@valid_attributes)
  end

  it 'should have a name' do
    @outcome_type.should respond_to(:name)
    @outcome_type.should respond_to(:name=)
  end
  
  it 'should provide the associated registrations' do
    OutcomeType.reflections.keys.should include(:registrations)
    OutcomeType.reflections[:registrations].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @outcome_type.should be_valid
    end
      
    it 'should require a name' do
      @outcome_type.name = nil
      @outcome_type.valid?
      @outcome_type.should have(1).error_on(:name)
    end
  end
end