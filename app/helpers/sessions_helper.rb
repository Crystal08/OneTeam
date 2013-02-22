module SessionsHelper

  def store_location
    session[:return_to] = request.url
  end  
	
  def sign_in(employee)
    cookies.permanent[:remember_token] = employee.remember_token
    self.current_employee = employee
  end

  def signed_in?
    !current_employee.nil?
  end

  def signed_in_employee
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def sign_out
    self.current_employee = nil
    cookies.delete(:remember_token)
  end

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
