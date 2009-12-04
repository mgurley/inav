require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  before(:each) do
    @valid_attributes = {
      :name => "United States",
      :code => "US"
    }
    @country = Country.new(@valid_attributes)
  end

  it 'should have a name' do
    @country.should respond_to(:name)
    @country.should respond_to(:name=)
  end
  
  it 'should have a code' do
    @country.should respond_to(:code)
    @country.should respond_to(:code=)
  end
  
  it 'should provide the associated addresses' do
    Country.reflections.keys.should include(:addresses)
    Country.reflections[:addresses].macro.should == :has_many
  end
  
  it 'should provide the associated state provinces' do
    Country.reflections.keys.should include(:state_provinces)
    Country.reflections[:state_provinces].macro.should == :has_many
  end
  
  describe 'validations' do
    
    it "should be vaild given valid attributes" do
      @country.should be_valid
    end
  
    it 'should require an name' do
      @country.name = nil
      @country.valid?
      @country.should have(1).error_on(:name)
    end
  
    it 'should require an code' do
      @country.code = nil
      @country.valid?
      @country.should have(1).error_on(:code)
    end
  end
end