require 'spec_helper'

describe "badges/index.html.erb" do
  before(:each) do
    assign(:badges, [
      stub_model(Badge),
      stub_model(Badge)
    ])
  end

  it "renders a list of badges" do
    render
  end
end
