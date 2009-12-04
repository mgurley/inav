require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProviderTypesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "provider_types", :action => "index").should == "/provider_types"
    end
  
    it "should map #new" do
      route_for(:controller => "provider_types", :action => "new").should == "/provider_types/new"
    end
  
    it "should map #show" do
      route_for(:controller => "provider_types", :action => "show", :id => "1").should == "/provider_types/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "provider_types", :action => "edit", :id => "1").should == "/provider_types/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "provider_types", :action => "update", :id => "1").should == {:path => "/provider_types/1", :method  => :put}
    end
  
    it "should map #destroy" do
      route_for(:controller => "provider_types", :action => "destroy", :id => "1").should == {:path => "/provider_types/1", :method  => :delete }
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/provider_types").should == {:controller => "provider_types", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/provider_types/new").should == {:controller => "provider_types", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/provider_types").should == {:controller => "provider_types", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/provider_types/1").should == {:controller => "provider_types", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/provider_types/1/edit").should == {:controller => "provider_types", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/provider_types/1").should == {:controller => "provider_types", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/provider_types/1").should == {:controller => "provider_types", :action => "destroy", :id => "1"}
    end
  end
end
