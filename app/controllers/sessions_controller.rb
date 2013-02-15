class SessionsController < ApplicationController

  def new
  end

  def create
    employee = Employee.find_by_email(params[:session][:email].downcase)
    if employee && employee.authenticate(params[:session][:password])
      sign_in employee
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end


