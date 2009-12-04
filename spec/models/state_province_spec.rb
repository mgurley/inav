require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StateProvince do
  before(:each) do
    @valid_attributes = {
      :name => "Illinois",
      :code => "IL",
      :country_id => "1"
    }
    @state_province = StateProvince.new(@valid_attributes)
  end

  it 'should have a name' do
    @state_province.should respond_to(:name)
    @state_province.should respond_to(:name=)
  end

  it 'should have a code' do
    @state_province.should respond_to(:code)
    @state_province.should respond_to(:code=)
  end

  it 'should have a country_id' do
    @state_province.should respond_to(:country_id)
    @state_province.should respond_to(:country_id=)
  end

  it 'should have an association to the country' do
    StateProvince.reflections.keys.should include(:country)
    StateProvince.reflections[:country].macro.should == :belongs_to
    StateProvince.reflections[:country].class_name.should == 'Country'
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @state_province.should be_valid
    end

    it 'should require a name' do
      @state_province.name = nil
      @state_province.valid?
      @state_province.should have(1).error_on(:name)
    end
  
    it 'should require a code' do
      @state_province.code = nil
      @state_province.valid?
      @state_province.should have(1).error_on(:code)
    end    
  end
end
