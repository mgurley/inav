require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProviderTypesController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
  end

  def mock_provider_type(stubs={})
    @mock_provider_type ||= mock_model(ProviderType, stubs)
  end
  
  describe "responding to GET index" do
    it "should expose all provider_types as @provider_types" do
      ProviderType.should_receive(:find).with(:all).and_return([mock_provider_type])
      get :index
      assigns[:provider_types].should == [mock_provider_type]
    end

    describe "with mime type of xml" do  
      it "should render all provider_types as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        ProviderType.should_receive(:find).with(:all).and_return(provider_types = mock("Array of ProviderTypes"))
        provider_types.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET show" do
    it "should expose the requested provider_type as @provider_type" do
      ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
      get :show, :id => "37"
      assigns[:provider_type].should equal(mock_provider_type)
    end
    
    describe "with mime type of xml" do

      it "should render the requested provider_type as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
        mock_provider_type.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET new" do
    it "should expose a new provider_type as @provider_type" do
      ProviderType.should_receive(:new).and_return(mock_provider_type)
      get :new
      assigns[:provider_type].should equal(mock_provider_type)
    end
  end

  describe "responding to GET edit" do
    it "should expose the requested provider_type as @provider_type" do
      ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
      get :edit, :id => "37"
      assigns[:provider_type].should equal(mock_provider_type)
    end
  end

  describe "responding to POST create" do
    describe "with valid params" do
      it "should expose a newly created provider_type as @provider_type" do
        ProviderType.should_receive(:new).with({'these' => 'params'}).and_return(mock_provider_type(:save => true))
        post :create, :provider_type => {:these => 'params'}
        assigns(:provider_type).should equal(mock_provider_type)
      end

      it "should redirect to the created provider_type" do
        ProviderType.stub!(:new).and_return(mock_provider_type(:save => true))
        post :create, :provider_type => {}
        response.should redirect_to(provider_type_url(mock_provider_type))
      end
    end
    
    describe "with invalid params" do
      it "should expose a newly created but unsaved provider_type as @provider_type" do
        ProviderType.stub!(:new).with({'these' => 'params'}).and_return(mock_provider_type(:save => false))
        post :create, :provider_type => {:these => 'params'}
        assigns(:provider_type).should equal(mock_provider_type)
      end

      it "should re-render the 'new' template" do
        ProviderType.stub!(:new).and_return(mock_provider_type(:save => false))
        post :create, :provider_type => {}
        response.should render_template('new')
      end
    end
  end

  describe "responding to PUT udpate" do
    describe "with valid params" do
      it "should update the requested provider_type" do
        ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
        mock_provider_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :provider_type => {:these => 'params'}
      end

      it "should expose the requested provider_type as @provider_type" do
        ProviderType.stub!(:find).and_return(mock_provider_type(:update_attributes => true))
        put :update, :id => "1"
        assigns(:provider_type).should equal(mock_provider_type)
      end

      it "should redirect to the provider_type" do
        ProviderType.stub!(:find).and_return(mock_provider_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(provider_type_url(mock_provider_type))
      end
    end
    
    describe "with invalid params" do
      it "should update the requested provider_type" do
        ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
        mock_provider_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :provider_type => {:these => 'params'}
      end

      it "should expose the provider_type as @provider_type" do
        ProviderType.stub!(:find).and_return(mock_provider_type(:update_attributes => false))
        put :update, :id => "1"
        assigns(:provider_type).should equal(mock_provider_type)
      end

      it "should re-render the 'edit' template" do
        ProviderType.stub!(:find).and_return(mock_provider_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
  end

  describe "responding to DELETE destroy" do
    it "should destroy the requested provider_type" do
      ProviderType.should_receive(:find).with("37").and_return(mock_provider_type)
      mock_provider_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the provider_types list" do
      ProviderType.stub!(:find).and_return(mock_provider_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(provider_types_url)
    end
  end
end
