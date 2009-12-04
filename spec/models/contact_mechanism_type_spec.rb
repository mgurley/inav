require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactMechanismType do
  before(:each) do
    @valid_attributes = {
      :name => "Phone"
    }
    @contact_mechanism_type = ContactMechanismType.new
  end

  it 'should have a name' do
    @contact_mechanism_type.should respond_to(:name)
    @contact_mechanism_type.should respond_to(:name=)
  end
  
  it 'should provide the associated contact mechanism' do
    ContactMechanismType.reflections.keys.should include(:contact_mechanisms)
    ContactMechanismType.reflections[:contact_mechanisms].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @contact_mechanism_type.attributes = @valid_attributes
      @contact_mechanism_type.should be_valid
    end
      
    it 'should require a name' do
      @contact_mechanism_type.name = ''
      @contact_mechanism_type.valid?
      @contact_mechanism_type.should have(1).error_on(:name)
    end
  end
end
