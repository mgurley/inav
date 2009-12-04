require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegistrationsController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
    session[:cas_user] = 'test user'
  end

  def mock_patient(stubs={})
    @mock_patient ||= mock_model(Patient, stubs)
  end

  def mock_registration(stubs={})
    @mock_registration ||= mock_model(Registration, stubs)
  end

  describe "responding to GET index" do
    it "should expose all registrations as @registrations" do
      Registration.should_receive(:search).with('1', 'foo', 'bar', 'test', 'test user', 'data').and_return([mock_registration])
      get :index, :page => '1', :sort => 'foo', :status => 'bar', :patients => 'test', :search => 'data'
      assigns[:registrations].should == [mock_registration]
    end    

    describe "with mime type of xml" do    
      it "should render all registrations as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Registration.should_receive(:search).with('1', 'foo', 'bar', 'test', 'test user', 'data').and_return(registrations = [mock_registration])
        registrations.should_receive(:to_xml).and_return("generated XML")
        get :index, :page => '1', :sort => 'foo', :status => 'bar', :patients => 'test', :search => 'data'
        response.body.should == "generated XML"
      end    
    end
  end

  describe "responding to GET show" do
    it "should redirect to the patient" do
      Registration.should_receive(:find).with("37").and_return(mock_registration)
      mock_registration.should_receive(:patient).and_return(mock_patient)
      get :show, :id => "inav-37"
      response.should redirect_to(patient_url(mock_patient))
    end
  end

  describe "responding to GET new" do
    it "should expose a new registration as @registration" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      Registration.should_receive(:new).and_return(mock_registration)
      get :new, :patient_id => "37"
      assigns[:registration].should equal(mock_registration)
    end
  end

  describe "responding to GET edit" do
    it "should expose the requested registration as @registration" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      Registration.should_receive(:find).with("37").and_return(mock_registration)
      get :edit, :id => "37", :patient_id => "37"
      assigns[:registration].should equal(mock_registration)
    end
  end

  describe "responding to POST create" do
    describe "with valid params" do
      it "should expose a newly created registration as @registration" do
        PatientStudyCalendar::Resources::Resource.stub!(:request_proxy_ticket=>'')
        Patient.should_receive(:find).with("37").and_return(mock_patient())
        Registration.should_receive(:new).with({'these' => 'params'}).and_return(mock_registration(:save_with_psc! => true, :registration_assignment_url=>''))
        post :create, :registration => {:these => 'params'}, :patient_id => "37"
        assigns(:registration).should equal(mock_registration)
      end

      it "should redirect to the created registration on the PSC side" do
        PatientStudyCalendar::Resources::Resource.stub!(:request_proxy_ticket=>'')
        Patient.should_receive(:find).with("37").and_return(mock_patient())
        Registration.stub!(:new).and_return(mock_registration(:save_with_psc! => true,:registration_assignment_url=>'http://psc.com'))
        post :create, :registration => {},:patient_id => "37"
        response.should redirect_to('http://psc.com')
      end
    end

    describe "with invalid params" do
      it "should re-render the 'new' template" do
        PatientStudyCalendar::Resources::Resource.stub!(:request_proxy_ticket=>'')
        Patient.should_receive(:find).with("37").and_return(mock_patient())
        Registration.should_receive(:new).twice.and_return(mock_registration(:registration_assignment_url=>''))
        mock_registration.should_receive(:save_with_psc!).and_raise(ArgumentError.new('error message'))
        mock_registration.errors.should_receive(:add)
        post :create, :registration => {}, :patient_id => "37"
        response.should render_template('new')
      end
    end
  end

  describe "responding to PUT udpate" do
    describe "with valid params" do
      it "should update the requested registration" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        Registration.should_receive(:find).with("37").and_return(mock_registration)
        mock_registration.should_receive(:update_attributes).with({'outcome' => 'Great'})
        put :update, :id => "37", :registration => {:outcome => 'Great'}, :patient_id => "37"
      end

      it "should expose the requested registration as @registration" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        Registration.stub!(:find).and_return(mock_registration(:update_attributes => true))
        put :update, :id => "1", :registration => {:outcome => 'Great'}, :patient_id => "37"
        assigns(:registration).should equal(mock_registration)
      end

      it "should redirect to the patient" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        Registration.stub!(:find).and_return(mock_registration(:update_attributes => true))
        put :update, :id => "1", :registration => {:outcome => 'Great'}, :patient_id => "37"
        response.should redirect_to(patient_url(mock_patient))
      end
    end

    describe "with invalid params" do
      it "should re-render the 'edit' template" do
        Patient.should_receive(:find).with("37").and_return(mock_patient())
        Registration.stub!(:find).and_return(mock_registration(:update_attributes => false))
        put :update, :id => "1", :registration => {}, :patient_id => "37"
        response.should render_template('edit')
      end
    end
  end

  describe "responding to DELETE destroy" do
    it "should redirect to the patient" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      Registration.stub!(:find).and_return(mock_registration())
      delete :destroy, :id => "1", :patient_id => "37"
      response.should redirect_to(patient_url(mock_patient))
    end
  end
end
