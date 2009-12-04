require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProvidersController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
  end

  def mock_provider(stubs={})
    @mock_provider ||= mock_model(Provider, stubs)
  end

  def mock_provider_view(stubs={})
    @mock_provider_view ||= mock_model(ProviderView, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all providers as @providers" do
      ProviderView.should_receive(:find).with(:all,{:order=>"first_name", :limit=>10, :offset=>0}).and_return([mock_provider_view])
      get :index
      assigns[:providers].should == [mock_provider_view]
    end

    describe "with mime type of xml" do
  
      it "should render all providers as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        ProviderView.should_receive(:find).with(:all).and_return(providers = mock("Array of Providers"))
        providers.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested provider as @provider" do
      Provider.should_receive(:find).with("37").and_return(mock_provider)
      get :show, :id => "37"
      assigns[:provider].should equal(mock_provider)
    end
    
    describe "with mime type of xml" do

      it "should render the requested provider as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Provider.should_receive(:find).with("37").and_return(mock_provider)
        mock_provider.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new provider as @provider" do
      Provider.should_receive(:new).and_return(mock_provider)
      get :new
      assigns[:provider].should equal(mock_provider)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested provider as @provider" do
      Provider.should_receive(:find).with("37").and_return(mock_provider)
      get :edit, :id => "37"
      assigns[:provider].should equal(mock_provider)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created provider as @provider" do
        Provider.should_receive(:new).with({'these' => 'params'}).and_return(mock_provider(:save => true))
        post :create, :provider => {:these => 'params'}
        assigns(:provider).should equal(mock_provider)
      end

      it "should redirect to the created provider" do
        Provider.stub!(:new).and_return(mock_provider(:save => true))
        post :create, :provider => {}
        response.should redirect_to(provider_url(mock_provider))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved provider as @provider" do
        Provider.stub!(:new).with({'these' => 'params'}).and_return(mock_provider(:save => false))
        post :create, :provider => {:these => 'params'}
        assigns(:provider).should equal(mock_provider)
      end

      it "should re-render the 'new' template" do
        Provider.stub!(:new).and_return(mock_provider(:save => false))
        post :create, :provider => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested provider" do
        Provider.should_receive(:find).with("37").and_return(mock_provider(:attributes= =>true))
        mock_provider.should_receive(:save)
        put :update, :id => "37", :provider => {:these => 'params'}
      end

      it "should expose the requested provider as @provider" do
        Provider.stub!(:find).and_return(mock_provider(:save => true,:attributes= =>true))
        put :update, :id => "1", :provider => {:these => 'params'}
        assigns(:provider).should equal(mock_provider)
      end

      it "should redirect to the provider" do
        Provider.stub!(:find).and_return(mock_provider(:save => true,:attributes= => true))
        put :update, :id => "1", :provider => {:these => 'params'}
        response.should redirect_to(provider_url(mock_provider))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested provider" do
        Provider.should_receive(:find).with("37").and_return(mock_provider(:attributes= =>true))
        mock_provider.should_receive(:save)
        put :update, :id => "37", :provider => {:these => 'params'}
      end

      it "should expose the provider as @provider" do
        Provider.stub!(:find).and_return(mock_provider(:save => false,:attributes= => true))
        put :update, :id => "1", :provider => {:these => 'params'}
        assigns(:provider).should equal(mock_provider)
      end

      it "should re-render the 'edit' template" do
        Provider.stub!(:find).and_return(mock_provider(:save => false,:attributes= => true))
        put :update, :id => "1", :provider => {:these => 'params'}
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do
  
    it "should redirect to the providers list" do
      Provider.stub!(:find).and_return(mock_provider)
      delete :destroy, :id => "1"
      response.should redirect_to(providers_url)
    end

    # it "should destroy the requested provider" do
    #   Provider.should_receive(:find).with("37").and_return(mock_provider)
    #   mock_provider.should_receive(:destroy)
    #   delete :destroy, :id => "37"
    # end
  end

end
