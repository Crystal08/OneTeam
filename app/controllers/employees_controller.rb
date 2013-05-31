class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]
 
  def index
    @employees = Employee.paginate :page => params[:page], :per_page => 10
    @page_tab = @employees_tab
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  def show
    @employee = Employee.find(params[:id])
    
    all_responses = Response.where('employee_id' => params[:id])
    employee_selections = []
    all_responses.each do |res|
      employee_selections.concat(Selection.where('response_id' => res.id))
    end
    
    @selections = employee_selections
    
    employee_selected_response_ids = 
      @selections.map(&:response_id)
    employee_selected_request_ids = []
    employee_selected_response_ids.each do |res_id|
      employee_selected_request_ids.push(Response.find(res_id).request_id)
    end
    
    @request_ids = employee_selected_request_ids  
    @my_projects = @request_ids.map{|request_id| Request.find(request_id)}
    
  
  end

  def new
    @employee = Employee.new
    @locations = Location.all
    @departments = Department.all
    @groups = Group.all
    @positions = Position.all
  end

  def edit
    @employee = Employee.find(params[:id])
    @locations = Location.all
    @departments = Department.all
    @groups = Group.all
    @positions = Position.all
  end

  def create
    @employee = Employee.new(params[:employee])
    @locations = Location.all
    @departments = Department.all
    @groups = Group.all
    @positions = Position.all

    if @employee.save
      sign_in @employee
      flash[:success] = "Welcome to OneTeam!"
      redirect_to @employee
    else
      render 'new'
    end
  end

  def update
    @employee = Employee.find(params[:id])
    @locations = Location.all
    @departments = Department.all
    @groups = Group.all
    @positions = Position.all
 
      if @employee.update_attributes(params[:employee])
        flash[:success] = "Account was successfully updated."
        sign_in @employee
        redirect_to @employee
      else
        render 'edit'
      end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  private

    def correct_user
      @employee = Employee.find(params[:id])
      if !current_employee?(@employee)
        flash[:notice] = "You are not authorized to edit this employee."
        redirect_to employees_path
      end	
    end      
end
