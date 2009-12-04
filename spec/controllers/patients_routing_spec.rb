require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatientsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "patients", :action => "index").should == "/patients"
    end
  
    it "should map #new" do
      route_for(:controller => "patients", :action => "new").should == "/patients/new"
    end
  
    it "should map #show" do
      route_for(:controller => "patients", :action => "show", :id => "1").should == "/patients/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "patients", :action => "edit", :id => "1").should == "/patients/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "patients", :action => "update", :id => "1").should == {:path  => "/patients/1", :method  => :put}
    end
  
    it "should map #destroy" do
      route_for(:controller => "patients", :action => "destroy", :id => "1").should == {:path  => "/patients/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/patients").should == {:controller => "patients", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/patients/new").should == {:controller => "patients", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/patients").should == {:controller => "patients", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/patients/1").should == {:controller => "patients", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/patients/1/edit").should == {:controller => "patients", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/patients/1").should == {:controller => "patients", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/patients/1").should == {:controller => "patients", :action => "destroy", :id => "1"}
    end
  end
end
