require 'spec_helper'

describe "evaluations/show" do
  before(:each) do
    @evaluation = assign(:evaluation, stub_model(Evaluation,
      :response_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
