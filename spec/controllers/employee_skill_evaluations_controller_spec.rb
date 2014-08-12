require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe EmployeeSkillEvaluationsController do

  # This should return the minimal set of attributes required to create a valid
  # EmployeeSkillEvaluation. As you add validations to EmployeeSkillEvaluation, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmployeeSkillEvaluationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all employee_skill_evaluations as @employee_skill_evaluations" do
      employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
      get :index, {}, valid_session
      assigns(:employee_skill_evaluations).should eq([employee_skill_evaluation])
    end
  end

  describe "GET show" do
    it "assigns the requested employee_skill_evaluation as @employee_skill_evaluation" do
      employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
      get :show, {:id => employee_skill_evaluation.to_param}, valid_session
      assigns(:employee_skill_evaluation).should eq(employee_skill_evaluation)
    end
  end

  describe "GET new" do
    it "assigns a new employee_skill_evaluation as @employee_skill_evaluation" do
      get :new, {}, valid_session
      assigns(:employee_skill_evaluation).should be_a_new(EmployeeSkillEvaluation)
    end
  end

  describe "GET edit" do
    it "assigns the requested employee_skill_evaluation as @employee_skill_evaluation" do
      employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
      get :edit, {:id => employee_skill_evaluation.to_param}, valid_session
      assigns(:employee_skill_evaluation).should eq(employee_skill_evaluation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EmployeeSkillEvaluation" do
        expect {
          post :create, {:employee_skill_evaluation => valid_attributes}, valid_session
        }.to change(EmployeeSkillEvaluation, :count).by(1)
      end

      it "assigns a newly created employee_skill_evaluation as @employee_skill_evaluation" do
        post :create, {:employee_skill_evaluation => valid_attributes}, valid_session
        assigns(:employee_skill_evaluation).should be_a(EmployeeSkillEvaluation)
        assigns(:employee_skill_evaluation).should be_persisted
      end

      it "redirects to the created employee_skill_evaluation" do
        post :create, {:employee_skill_evaluation => valid_attributes}, valid_session
        response.should redirect_to(EmployeeSkillEvaluation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved employee_skill_evaluation as @employee_skill_evaluation" do
        # Trigger the behavior that occurs when invalid params are submitted
        EmployeeSkillEvaluation.any_instance.stub(:save).and_return(false)
        post :create, {:employee_skill_evaluation => {}}, valid_session
        assigns(:employee_skill_evaluation).should be_a_new(EmployeeSkillEvaluation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        EmployeeSkillEvaluation.any_instance.stub(:save).and_return(false)
        post :create, {:employee_skill_evaluation => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested employee_skill_evaluation" do
        employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
        # Assuming there are no other employee_skill_evaluations in the database, this
        # specifies that the EmployeeSkillEvaluation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        EmployeeSkillEvaluation.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => employee_skill_evaluation.to_param, :employee_skill_evaluation => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested employee_skill_evaluation as @employee_skill_evaluation" do
        employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
        put :update, {:id => employee_skill_evaluation.to_param, :employee_skill_evaluation => valid_attributes}, valid_session
        assigns(:employee_skill_evaluation).should eq(employee_skill_evaluation)
      end

      it "redirects to the employee_skill_evaluation" do
        employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
        put :update, {:id => employee_skill_evaluation.to_param, :employee_skill_evaluation => valid_attributes}, valid_session
        response.should redirect_to(employee_skill_evaluation)
      end
    end

    describe "with invalid params" do
      it "assigns the employee_skill_evaluation as @employee_skill_evaluation" do
        employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        EmployeeSkillEvaluation.any_instance.stub(:save).and_return(false)
        put :update, {:id => employee_skill_evaluation.to_param, :employee_skill_evaluation => {}}, valid_session
        assigns(:employee_skill_evaluation).should eq(employee_skill_evaluation)
      end

      it "re-renders the 'edit' template" do
        employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        EmployeeSkillEvaluation.any_instance.stub(:save).and_return(false)
        put :update, {:id => employee_skill_evaluation.to_param, :employee_skill_evaluation => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested employee_skill_evaluation" do
      employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
      expect {
        delete :destroy, {:id => employee_skill_evaluation.to_param}, valid_session
      }.to change(EmployeeSkillEvaluation, :count).by(-1)
    end

    it "redirects to the employee_skill_evaluations list" do
      employee_skill_evaluation = EmployeeSkillEvaluation.create! valid_attributes
      delete :destroy, {:id => employee_skill_evaluation.to_param}, valid_session
      response.should redirect_to(employee_skill_evaluations_url)
    end
  end

end