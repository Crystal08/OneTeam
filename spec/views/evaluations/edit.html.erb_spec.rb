require 'spec_helper'

describe "evaluations/edit" do
  before(:each) do
    @evaluation = assign(:evaluation, stub_model(Evaluation,
      :response_id => 1
    ))
  end

  it "renders the edit evaluation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => evaluations_path(@evaluation), :method => "post" do
      assert_select "input#evaluation_response_id", :name => "evaluation[response_id]"
    end
  end
end
