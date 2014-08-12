require 'spec_helper'

describe "evaluations/new" do
  before(:each) do
    assign(:evaluation, stub_model(Evaluation,
      :response_id => 1
    ).as_new_record)
  end

  it "renders new evaluation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => evaluations_path, :method => "post" do
      assert_select "input#evaluation_response_id", :name => "evaluation[response_id]"
    end
  end
end
