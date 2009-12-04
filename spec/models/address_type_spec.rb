require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AddressType do
  before(:each) do
    @valid_attributes = {
      :name => "Home"
    }
    @address_type = AddressType.new(@valid_attributes)
  end

  it 'should have a name' do
    @address_type.should respond_to(:name)
    @address_type.should respond_to(:name=)
  end
  
  it 'should provide the associated addresses' do
    AddressType.reflections.keys.should include(:addresses)
    AddressType.reflections[:addresses].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @address_type.should be_valid
    end
      
    it 'should require a name' do
      @address_type.name = nil
      @address_type.valid?
      @address_type.should have(1).error_on(:name)
    end
  end
end