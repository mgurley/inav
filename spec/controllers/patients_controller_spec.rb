require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientsController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
  end

  def mock_patient(stubs={})
    @mock_patient ||= mock_model(Patient, stubs)
  end
  
  def mock_patient_view(stubs={})
    @mock_patient_view ||= mock_model(PatientView, stubs)
  end
  
  
  describe "responding to GET index" do

    it "should expose all patients as @patients" do      
      PatientView.should_receive(:find).with(:all,{:order=>"last_name", :limit=>10, :offset=>0}).and_return([mock_patient_view])
      get :index
      assigns[:patients].should == [mock_patient_view]
    end

    describe "with mime type of xml" do
  
      it "should render all patients as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PatientView.should_receive(:find).with(:all).and_return(patients = mock("Array of Patients"))
        patients.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do
  
    it "should expose the requested patient as @patient" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      get :show, :id => "37"
      assigns[:patient].should equal(mock_patient)
    end
    
    describe "with mime type of xml" do
  
      it "should render the requested patient as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Patient.should_receive(:find).with("37").and_return(mock_patient)
        mock_patient.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end
  
    end
    
  end
  
  describe "responding to GET new" do
  
    it "should expose a new patient as @patient" do
      Patient.should_receive(:new).and_return(mock_patient)
      get :new
      assigns[:patient].should equal(mock_patient)
    end
  
  end
  
  describe "responding to GET edit" do
  
    it "should expose the requested patient as @patient" do
      Patient.should_receive(:find).with("37").and_return(mock_patient)
      get :edit, :id => "37"
      assigns[:patient].should equal(mock_patient)
    end
  
  end
  
  describe "responding to POST create" do
  
    describe "with valid params" do
      
      it "should expose a newly created patient as @patient" do
        Patient.should_receive(:new).with({'these' => 'params'}).and_return(mock_patient(:save => true,:attributes => {}))
        Patient.should_receive(:duplicate?).and_return(false)
        post :create, :patient => {:these => 'params'}
        assigns(:patient).should equal(mock_patient)
      end
  
      it "should redirect to the patient url" do
        Patient.stub!(:new).and_return(mock_patient(:save => true, :attributes => {}))
        Patient.should_receive(:duplicate?).and_return(false)
        post :create, :patient => {}
        response.should redirect_to(patient_url(mock_patient))
      end
            
      it "should redirect to the patient url if a duplicate patient is being created and the user has confirmed"  do
        patient_attributes = {:first_name => 'Harold', :last_name => 'Baines', :date_of_birth => '3/15/1959' }
        patient = Patient.new(patient_attributes)
        Patient.should_receive(:duplicate?).and_return(true)
        Patient.stub!(:new).and_return(mock_patient(:save => true, :attributes => patient.attributes))
        duplicate_patient = {}
        duplicate_patient['first_name'] = patient.attributes['first_name']
        duplicate_patient['last_name'] =  patient.attributes['last_name']
        duplicate_patient['created_at'] = patient.attributes['created_at']
        controller.session[:duplicate_patient] = duplicate_patient
        post :create, :patient => patient_attributes
        response.should redirect_to(patient_url(mock_patient))
      end                  
    end
    
    describe "with invalid params" do
  
      it "should expose a newly created but unsaved patient as @patient" do
        Patient.stub!(:new).with({'these' => 'params'}).and_return(mock_patient(:save => false, :attributes =>{}))
        Patient.should_receive(:duplicate?).and_return(false)
        post :create, :patient => {:these => 'params'}
        assigns(:patient).should equal(mock_patient)
      end
  
      it "should re-render the 'new' template" do
        Patient.stub!(:new).and_return(mock_patient(:save => false,:attributes =>{}))
        Patient.should_receive(:duplicate?).and_return(false)
        post :create, :patient => {}
        response.should render_template('new')
      end
  
      it "should re-render the 'new' template if a duplicate patient is being created and the user has not confirmed" do
        patient_attributes = {:first_name => 'Harold', :last_name => 'Baines', :date_of_birth => '3/15/1959' }
        patient = Patient.new(patient_attributes)
        Patient.should_receive(:duplicate?).and_return(true)
        Patient.stub!(:new).and_return(mock_patient(:save => true, :attributes => patient.attributes))
        post :create, :patient => patient_attributes
        response.should render_template('new')
      end              
    end
  end
  
  describe "responding to PUT udpate" do
  
    describe "with valid params" do
  
      it "should update the requested patient" do
        Patient.should_receive(:find).with("37").and_return(mock_patient(:attributes= =>true))
        mock_patient.should_receive(:save)
        put :update, :id => "37", :patient => {:these => 'params'}
      end
  
      it "should expose the requested patient as @patient" do
        Patient.stub!(:find).and_return(mock_patient(:save => true,:attributes= =>true))
        put :update, :id => "1", :patient => {:these => 'params'}
        assigns(:patient).should equal(mock_patient)
      end
  
      it "should redirect to the patient" do
        Patient.stub!(:find).and_return(mock_patient(:save => true,:attributes= => true))
        put :update, :id => "1", :patient => {:these => 'params'}
        response.should redirect_to(patient_url(mock_patient))
      end
  
    end
    
    describe "with invalid params" do
  
      it "should update the requested patient" do
        Patient.should_receive(:find).with("37").and_return(mock_patient(:attributes= =>true))
        mock_patient.should_receive(:save)
        put :update, :id => "37", :patient => {:these => 'params'}
      end
  
      it "should expose the patient as @patient" do
        Patient.stub!(:find).and_return(mock_patient(:save => false,:attributes= => true))
        put :update, :id => "1", :patient => {:these => 'params'}
        assigns(:patient).should equal(mock_patient)
      end
  
      it "should re-render the 'edit' template" do
        Patient.stub!(:find).and_return(mock_patient(:save => false,:attributes= => true))
        put :update, :id => "1", :patient => {:these => 'params'}
        response.should render_template('edit')
      end
  
    end
  
  end
  
  describe "responding to DELETE destroy" do
    # it "should redirect to the patients list" do
    #   Patient.stub!(:find).and_return(mock_patient)
    #   mock_patient.should_receive(:destroy)
    #   delete :destroy, :id => "1"
    #   response.should redirect_to(patients_url)
    # end
    
    # it "should destroy the requested patient" do
    #   Patient.should_receive(:find).with("37").and_return(mock_patient)
    #   mock_patient.should_receive(:destroy)
    #   @mock_patient.errors.full_messages.should_receive(:join)
    #   delete :destroy, :id => "37"
    # end
  end
end