require 'spec_helper'

describe HubController do
  render_views
  
  describe "GET 'login'" do
    it "should be successful" do
      get 'login'
      response.should have_selector("title", :content => "Login")
    end
  end

end
