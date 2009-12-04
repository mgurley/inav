require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Address do
  before(:each) do
    @valid_attributes = {
        :attention => "value for attention",
        :address_line_1 => "value for address_line_1",
        :address_line_2 => "value for attention",
        :state_province_name => "value for address_line_2",
        :city => "value for city",
        :postal_code => "value for postal_code",
        :country_id => "value for attention",
        :addressable_id => "1",
        :addressable_type => "value for addressable_type",
        :address_type_id => "1"
    }
    @address = Address.new(@valid_attributes)
  end

  it 'should have a attention' do
    @address.should respond_to(:attention)
    @address.should respond_to(:attention=)
  end

  it 'should have a address line 1' do
    @address.should respond_to(:address_line_1)
    @address.should respond_to(:address_line_1=)
  end

  it 'should have a address line 2' do
    @address.should respond_to(:address_line_2)
    @address.should respond_to(:address_line_2=)
  end

  it 'should have a state province name' do
    @address.should respond_to(:state_province_name)
    @address.should respond_to(:state_province_name=)
  end

  it 'should have a city' do
    @address.should respond_to(:city)
    @address.should respond_to(:city=)
  end

  it 'should have a postal code' do
    @address.should respond_to(:postal_code)
    @address.should respond_to(:postal_code=)
  end

  it 'should have a country' do
    @address.should respond_to(:country_id)
    @address.should respond_to(:country_id=)
  end

  it 'should have an addressable_id' do
    @address.should respond_to(:addressable_id)
    @address.should respond_to(:addressable_id=)
  end

  it 'should have an addressable_type' do
    @address.should respond_to(:addressable_type)
    @address.should respond_to(:addressable_type=)
  end


  it 'should have an address type' do
    @address.should respond_to(:address_type_id)
    @address.should respond_to(:address_type_id=)
  end
  
  it 'should have an association to the addressable' do
    Address.reflections.keys.should include(:addressable)
    Address.reflections[:addressable].macro.should == :belongs_to
    Address.reflections[:addressable].class_name.should == 'Addressable'
  end

  it 'should have an association to the address type' do
    Address.reflections.keys.should include(:address_type)
    Address.reflections[:address_type].macro.should == :belongs_to
    Address.reflections[:address_type].class_name.should == 'AddressType'
  end


  it 'should have an association to the country' do
    Address.reflections.keys.should include(:country)
    Address.reflections[:country].macro.should == :belongs_to
    Address.reflections[:country].class_name.should == 'Country'
  end


  describe 'validations' do

    it "should be vaild given valid attributes" do
      @address.should be_valid
    end  

    it 'should require an address line 1' do
      @address.address_line_1 = nil
      @address.valid?
      @address.should have(1).error_on(:address_line_1)
    end

    it 'should require a state province' do
      @address.state_province_name = nil
      @address.valid?
      @address.should have(1).error_on(:state_province_name)
    end

    it 'should require a city' do
      @address.city = nil
      @address.valid?
      @address.should have(1).error_on(:city)
    end

    it 'should require a postal code' do
      @address.postal_code = nil
      @address.valid?
      @address.should have(1).error_on(:postal_code)
    end

    it 'should require a country' do
      @address.country_id = nil
      @address.valid?
      @address.should have(1).error_on(:country_id)
    end

    it 'should require a type of address' do
      @address.address_type_id = nil
      @address.valid?
      @address.should have(1).error_on(:address_type_id)
    end
  end
end
