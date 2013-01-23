class SelectedEmployeesController < ApplicationController
  before_filter :signed_in_employee
  
  def index
    @selected_employee = SelectedEmployee.all
  end

  def show
    @selected_employee = SelectedEmployee.find(params[:id])
  end

  def new
    @selected_employee = SelectedEmployee.new
  end

  def edit 
    @selected_employee = SelectedEmployee.find(params[:id])
  end

  def create  
    @selected_employee = SelectedEmployee.new(params[:selected_employee])

    respond_to do |format|
      if @selected_employee.save
        format.html { redirect_to selected_employee_path(@selected_employee), notice: 'Selected employee was successfully created.' }
        format.json { render json: @selected_employee, status: :created, location: @selected_employee }
      else
        format.html { render action: "new" }
        format.json { render json: @selected_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /selected_employees/1
  # PUT /selected_employees/1.json
  def update
    @selected_employee = SelectedEmployee.find(params[:id])

    respond_to do |format|
      if @selected_employee.update_attributes(params[:selected_employee])
        format.html { redirect_to @selected_employee, notice: 'Selected employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selected_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selected_employees/1
  # DELETE /selected_employees/1.json
  def destroy
    @selected_employee = SelectedEmployee.find(params[:id])
    @selected_employee.destroy

    respond_to do |format|
      format.html { redirect_to selected_employees_url }
      format.json { head :no_content }
    end
  end
end
