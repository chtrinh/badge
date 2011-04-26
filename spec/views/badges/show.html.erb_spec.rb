require 'spec_helper'

describe "badges/show.html.erb" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge))
  end

  it "renders attributes in <p>" do
    render
  end
end
