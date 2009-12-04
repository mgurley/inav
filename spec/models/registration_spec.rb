require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Registration do
  before(:each) do
    @valid_attributes = {
      :patient_id => "1",
      :site_assigned_identifier => "value for site_assigned_identifier",
      :study_assigned_identifier => "value for study_assigned_identifier",
      :study_segment_id => "value for study_segment_id",
      :epoch_name => "value for epoch_name",
      :study_segment_name => "value for study_segment_name",
      :subject_coordinator_name => "value for subject_coordinator_name",
      :outcome => "value for outcome",
      :referring_provider_id => "1",
      :inflection_date => "12-10-2008",
      :outcome_type_id => "1",
      :outcome_date => nil
    }
    @registration = Registration.new(@valid_attributes)
  end

  it 'should have a patient' do
    @registration.should respond_to(:patient_id)
    @registration.should respond_to(:patient_id=)
  end

  it 'should have a site assigned identifier' do
    @registration.should respond_to(:site_assigned_identifier)
    @registration.should respond_to(:site_assigned_identifier=)
  end

  it 'should have a study assigned identifier' do
    @registration.should respond_to(:study_assigned_identifier)
    @registration.should respond_to(:study_assigned_identifier=)
  end

  it 'should have a study segment name' do
    @registration.should respond_to(:study_segment_name)
    @registration.should respond_to(:study_segment_name=)
  end

  it 'should have a study segment' do
    @registration.should respond_to(:study_segment_id)
    @registration.should respond_to(:study_segment_id=)
  end

  it 'should have an outcome' do
    @registration.should respond_to(:outcome)
    @registration.should respond_to(:outcome=)
  end

  it 'should have a referring provider' do
    @registration.should respond_to(:referring_provider_id)
    @registration.should respond_to(:referring_provider_id=)
  end

  it 'should have a study epoch name' do
    @registration.should respond_to(:epoch_name)
    @registration.should respond_to(:epoch_name=)
  end

  it 'should have a study subject coordinator name' do
    @registration.should respond_to(:subject_coordinator_name)
    @registration.should respond_to(:subject_coordinator_name=)
  end

  it 'should have an inflection date' do
    @registration.should respond_to(:inflection_date)
    @registration.should respond_to(:inflection_date=)
  end

  it 'should have an outcome type' do
    @registration.should respond_to(:outcome_type_id)
    @registration.should respond_to(:outcome_type_id=)
  end

  it 'should have an outcome date' do
    @registration.should respond_to(:outcome_date)
    @registration.should respond_to(:outcome_date=)
  end

  it 'should have an association to the patient' do
    Registration.reflections.keys.should include(:patient)
    Registration.reflections[:patient].macro.should == :belongs_to
    Registration.reflections[:patient].class_name.should == 'Patient'
  end


  it 'should have an association to the provider' do
    Registration.reflections.keys.should include(:provider)
    Registration.reflections[:provider].macro.should == :belongs_to
    Registration.reflections[:provider].class_name.should == 'Provider'
  end


  it 'should have an association to the outcome type' do
    Registration.reflections.keys.should include(:outcome_type)
    Registration.reflections[:outcome_type].macro.should == :belongs_to
    Registration.reflections[:outcome_type].class_name.should == 'OutcomeType'
  end

  describe 'validations' do

    it "should be vaild given valid attributes" do
      @registration.should be_valid
    end

    it 'should require a patient' do
      @registration.patient_id = nil
      @registration.valid?
      @registration.should have(1).error_on(:patient_id)
    end
    
    it 'should require a site assigned identifier' do
      @registration.site_assigned_identifier = nil
      @registration.valid?
      @registration.should have(1).error_on(:site_assigned_identifier)
    end
    
    it 'should require a study assigned identifier' do
      @registration.study_assigned_identifier = nil
      @registration.valid?
      @registration.should have(1).error_on(:study_assigned_identifier)
    end

    it 'should require a study segment id' do
      @registration.study_segment_id = nil
      @registration.valid?
      @registration.should have(1).error_on(:study_segment_id)
    end

    it 'should require a study segment name' do
      @registration.study_segment_name = nil
      @registration.valid?
      @registration.should have(1).error_on(:study_segment_name)
    end
    
    it 'should require a study referring provider' do
      @registration.referring_provider_id = nil
      @registration.valid?
      @registration.should have(1).error_on(:referring_provider_id)
    end
    
    it 'should require a epoch name' do
      @registration.epoch_name = nil
      @registration.valid?
      @registration.should have(1).error_on(:epoch_name)
    end

    it 'should require an inflection date' do
      @registration.inflection_date = nil
      @registration.valid?
      @registration.should have(1).error_on(:inflection_date)
    end

    it 'should require an outcome type' do
      @registration.outcome_type_id = nil
      @registration.valid?
      @registration.should have(1).error_on(:outcome_type_id)
    end    
    
    it 'should not allow an coutcome date to be before an inflection date ' do
      @registration.outcome_date = "12-10-2008"
      @registration.created_at = "12-10-2007"
      @registration.inflection_date = "12-10-2009"
      @registration.valid?
      @registration.should have(1).error_on(:outcome_date)
    end        
    
    it 'should not allow an coutcome date to be before a registration date ' do
      @registration.outcome_date = "12-10-2008"
      @registration.inflection_date = "12-10-2007"
      @registration.created_at = "12-10-2009"
      @registration.valid?
      @registration.should have(1).error_on(:outcome_date)
    end            
  end
end