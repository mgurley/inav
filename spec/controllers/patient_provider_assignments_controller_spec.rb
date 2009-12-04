require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientProviderAssignmentsController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
  end

  def mock_patient(stubs={})
    @mock_patient ||= mock_model(Patient, stubs)
  end

  def mock_patient_provider_assignment(stubs={})
    @mock_patient_provider_assignment ||= mock_model(PatientProviderAssignment, stubs)
  end
  
  describe "responding to GET index" do
    it "should redirect to home" do
      get :index
      response.should redirect_to(root_url)
    end
  end

  describe "responding to GET show" do
    it "should redirect to home" do
      get :show, :id => "37"
      response.should redirect_to(root_url)      
    end    
  end

  describe "responding to GET new" do  
    it "should expose a new patient_provider_assignment as @patient_provider_assignment" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      PatientProviderAssignment.should_receive(:new).and_return(mock_patient_provider_assignment(:defaults => true))
      get :new, :patient_id => "37"
      assigns[:patient_provider_assignment].should equal(mock_patient_provider_assignment)
    end
  end

  describe "responding to GET edit" do
    it "should expose the requested patient_provider_assignment as @patient_provider_assignment" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      PatientProviderAssignment.should_receive(:find).with("37").and_return(mock_patient_provider_assignment)
      get :edit, :id => "37", :patient_id => "37"
      assigns[:patient_provider_assignment].should equal(mock_patient_provider_assignment)
    end
  end

  describe "responding to POST create" do
    describe "with valid params" do
      it "should expose a newly created patient_provider_assignment as @patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.should_receive(:new).with({'these' => 'params'}).and_return(mock_patient_provider_assignment(:save => true, :patient_id= =>true))
        post :create, :patient_provider_assignment => {:these => 'params'}, :patient_id => "37"
        assigns(:patient_provider_assignment).should equal(mock_patient_provider_assignment)
      end

      it "should redirect to the patient" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:new).and_return(mock_patient_provider_assignment(:save => true, :patient_id= =>true))
        post :create, :patient_provider_assignment => {}, :patient_id => "37"
        response.should redirect_to(patient_url(mock_patient))
      end      
    end
    
    describe "with invalid params" do
      it "should expose a newly created but unsaved patient_provider_assignment as @patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.should_receive(:new).with({'these' => 'params'}).and_return(mock_patient_provider_assignment(:save => false , :patient_id= =>true))
        post :create, :patient_provider_assignment => {:these => 'params'}, :patient_id => "37"
        assigns(:patient_provider_assignment).should equal(mock_patient_provider_assignment)
      end

      it "should re-render the 'new' template" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:new).and_return(mock_patient_provider_assignment(:save => false, :patient_id= =>true))
        post :create, :patient_provider_assignment => {}, :patient_id => "37"
        response.should render_template('new')
      end    
    end    
  end

  describe "responding to PUT udpate" do
    describe "with valid params" do
      it "should update the requested patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.should_receive(:find).with("37").and_return(mock_patient_provider_assignment)
        mock_patient_provider_assignment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :patient_provider_assignment => {:these => 'params'}, :patient_id => "37"
      end

      it "should expose the requested patient_provider_assignment as @patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:find).and_return(mock_patient_provider_assignment(:update_attributes => true))
        put :update, :id => "1", :patient_id => "37"
        assigns(:patient_provider_assignment).should equal(mock_patient_provider_assignment)
      end

      it "should redirect to the patient" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:find).and_return(mock_patient_provider_assignment(:update_attributes => true))
        put :update, :id => "1", :patient_id => "37"
        response.should redirect_to(patient_url(mock_patient))
      end
    end
    
    describe "with invalid params" do
      it "should update the requested patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.should_receive(:find).with("37").and_return(mock_patient_provider_assignment)
        mock_patient_provider_assignment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :patient_provider_assignment => {:these => 'params'}, :patient_id => "37"
      end

      it "should expose the patient_provider_assignment as @patient_provider_assignment" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:find).and_return(mock_patient_provider_assignment(:update_attributes => false))
        put :update, :id => "1", :patient_id => "37"
        assigns(:patient_provider_assignment).should equal(mock_patient_provider_assignment)
      end

      it "should re-render the 'edit' template" do
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        PatientProviderAssignment.stub!(:find).and_return(mock_patient_provider_assignment(:update_attributes => false))
        put :update, :id => "1", :patient_id => "37"
        response.should render_template('edit')
      end
    end
  end

  describe "responding to DELETE destroy" do
    it "should destroy the requested patient_provider_assignment" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      PatientProviderAssignment.should_receive(:find).with("37").and_return(mock_patient_provider_assignment)
      mock_patient_provider_assignment.should_receive(:destroy)
      delete :destroy, :id => "37", :patient_id => "37"
    end
  
    it "should redirect to the patient_provider_assignments list" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      PatientProviderAssignment.stub!(:find).and_return(mock_patient_provider_assignment(:destroy => true))
      delete :destroy, :id => "1", :patient_id => "37"
      response.should redirect_to(patient_url(mock_patient))
    end
  end
end
