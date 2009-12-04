require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProviderType do
  before(:each) do
    @valid_attributes = {
      :name => "Physician"
    }
    @provider_type = ProviderType.new(@valid_attributes)
  end

  it 'should have a name' do
    @provider_type.should respond_to(:name)
    @provider_type.should respond_to(:name=)
  end
  
  it 'should provide the associated providers' do
    ProviderType.reflections.keys.should include(:providers)
    ProviderType.reflections[:providers].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @provider_type.should be_valid
    end
      
    it 'should require a name' do
      @provider_type.name = nil
      @provider_type.valid?
      @provider_type.should have(1).error_on(:name)
    end
  end

end
