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
    @selections = Selection.where('employee_id' => params[:id])
    @requests = @selections.map{|selection| selection.request_id}
    @my_projects = @requests.map{|request| Request.find(request)}
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
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
