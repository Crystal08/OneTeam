module ApplicationHelper

  def current_employee=(employee)
    @current_employee = employee
  end

  def current_employee
    @current_employee ||= Employee.find_by_remember_token(cookies[:remember_token])
  end

  def current_employee?(employee)
    employee == current_employee
  end

end
