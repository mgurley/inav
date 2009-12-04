require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProvidersController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "providers", :action => "index").should == "/providers"
    end
  
    it "should map #new" do
      route_for(:controller => "providers", :action => "new").should == "/providers/new"
    end
  
    it "should map #show" do
      route_for(:controller => "providers", :action => "show", :id => "1").should == "/providers/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "providers", :action => "edit", :id => "1").should == "/providers/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "providers", :action => "update", :id => "1").should == {:path => "/providers/1", :method  => :put}
    end
  
    it "should map #destroy" do
      route_for(:controller => "providers", :action => "destroy", :id => "1").should == {:path => "/providers/1", :method  => :delete }
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/providers").should == {:controller => "providers", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/providers/new").should == {:controller => "providers", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/providers").should == {:controller => "providers", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/providers/1").should == {:controller => "providers", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/providers/1/edit").should == {:controller => "providers", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/providers/1").should == {:controller => "providers", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/providers/1").should == {:controller => "providers", :action => "destroy", :id => "1"}
    end
  end
end
