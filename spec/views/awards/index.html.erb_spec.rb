require 'spec_helper'

describe "awards/index.html.erb" do
  before(:each) do
    assign(:awards, [
      stub_model(Award),
      stub_model(Award)
    ])
  end

  it "renders a list of awards" do
    render
  end
end
