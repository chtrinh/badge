require 'spec_helper'

describe "awards/show.html.erb" do
  before(:each) do
    @award = assign(:award, stub_model(Award))
  end

  it "renders attributes in <p>" do
    render
  end
end
