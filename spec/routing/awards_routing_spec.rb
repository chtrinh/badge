require "spec_helper"

describe AwardsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/awards" }.should route_to(:controller => "awards", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/awards/new" }.should route_to(:controller => "awards", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/awards/1" }.should route_to(:controller => "awards", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/awards/1/edit" }.should route_to(:controller => "awards", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/awards" }.should route_to(:controller => "awards", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/awards/1" }.should route_to(:controller => "awards", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/awards/1" }.should route_to(:controller => "awards", :action => "destroy", :id => "1")
    end

  end
end
