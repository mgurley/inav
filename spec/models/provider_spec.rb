require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Provider do
  fixtures :provider_types, :providers
  before(:each) do
    @valid_attributes = {
      :first_name => "Leon",
      :last_name => "Durham",
      :middle_name => "L",
      :provider_type_id => "1",
      :national_provider_identifier => "1111111111"
    }
    @provider = Provider.new(@valid_attributes)
  end

  it 'should have a first name' do
    @provider.should respond_to(:first_name)
    @provider.should respond_to(:first_name=)
  end

  it 'should have a last name' do
    @provider.should respond_to(:last_name)
    @provider.should respond_to(:last_name=)
  end

  it 'should have a middle name' do
    @provider.should respond_to(:middle_name)
    @provider.should respond_to(:middle_name=)
  end

  it 'should have a provider type' do
    @provider.should respond_to(:provider_type_id)
    @provider.should respond_to(:provider_type_id=)
  end

  it 'should have a national provider identifier' do
    @provider.should respond_to(:national_provider_identifier)
    @provider.should respond_to(:national_provider_identifier=)
  end
  
  it 'should have a note' do
    @provider.should respond_to(:note)
    @provider.should respond_to(:note=)
  end

  it 'should have an association to the provider type' do
    Provider.reflections.keys.should include(:provider_type)
    Provider.reflections[:provider_type].macro.should == :belongs_to
    Provider.reflections[:provider_type].class_name.should == 'ProviderType'
  end

  it 'should provide the associated patients' do
    Provider.reflections.keys.should include(:patients)
    Provider.reflections[:patients].macro.should == :has_many
  end

  it 'should provide the associated contact mechanisms' do
    Provider.reflections.keys.should include(:contact_mechanisms)
    Provider.reflections[:contact_mechanisms].macro.should == :has_many
  end

  it 'should provide the associated addresses' do
    Provider.reflections.keys.should include(:addresses)
    Provider.reflections[:addresses].macro.should == :has_many
  end

  it 'should provide the associated patient provider assignments' do
    Provider.reflections.keys.should include(:patient_provider_assignments)
    Provider.reflections[:patient_provider_assignments].macro.should == :has_many
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @provider.should be_valid
    end
  
    it 'should require a first name' do
      @provider.first_name = nil
      @provider.valid?
      @provider.should have(1).error_on(:first_name)
    end

    it 'should require a last name' do
      @provider.last_name = nil
      @provider.valid?
      @provider.should have(1).error_on(:last_name)
    end

    it 'should require a provider type' do
      @provider.provider_type_id = nil
      @provider.valid?
      @provider.should have(1).error_on(:provider_type_id)
    end
  end

  describe "validaitons for uniqueness" do
   before(:each) do
       @provider_doogie = Provider.find(providers(:Doogie).id)
    end

   it 'should not be able to assign the same NPI to two providers' do
     provider = Provider.new(@valid_attributes.merge(:national_provider_identifier => @provider_doogie.national_provider_identifier))
     provider.valid?
     provider.should have(1).error_on(:national_provider_identifier)
   end        

  end  

  describe "validaitons for maxlength" do
   before(:each) do
       @provider_doogie = Provider.find(providers(:Doogie).id)
    end

   it 'should be inavalid if it is not exactly 10 characters' do
     @provider_doogie.national_provider_identifier = "1"
     @provider_doogie.valid?
     @provider_doogie.should have(1).error_on(:national_provider_identifier)
   end        

  end    

  describe "by_auto_complete named scope finder" do
    
    it 'should find poviders based on first name' do
      @providers = Provider.by_auto_complete "Doogie"
      @providers.should include(providers(:Doogie))  
    end        

    it 'should find poviders based on last name' do
      @providers = Provider.by_auto_complete "Ratchet"
      @providers.should include(providers(:Mildred))  
    end        

    it 'should find poviders based on national provider identifier' do
      @providers = Provider.by_auto_complete "5555555555"
      @providers.should include(providers(:Florence))  
    end        
  end     

  describe "by_auto_complete named scope finder" do
    
    it 'should find poviders based on first name' do
      @providers = Provider.by_auto_complete "Doogie"
      @providers.should include(providers(:Doogie))  
    end        
  end
    
  describe "getting a full name" do
    it "should display the provider's full name" do
      @provider.full_name.should == "Leon L Durham"
    end

    it "should display the provider's full name with NPI if requested" do
      @provider.full_name_with_npi.should == "Leon L Durham NPI: 1111111111"
      @provider.full_name({:npi => true}).should == "Leon L Durham NPI: 1111111111"
    end    
  end  
end