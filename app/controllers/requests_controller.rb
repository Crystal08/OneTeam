class RequestsController < ApplicationController
  before_filter :non_user, only: [:index] #in case of current_employee nil when new user goes straight to root url via /
  before_filter :signed_in_employee
  before_filter :correct_employee, only: [:edit, :update, :destroy]
  
  def index 
    @current_date = DateTime.now.to_date 

    if params[:employee_id]
      @my_requests = Request.where("employee_id = ?",
       params[:employee_id])
      @requests = @my_requests.paginate :page =>
       params[:page], :per_page => 10 
      render 'my_requests' 
    else 
      @requests = Request.paginate :page =>
       params[:page], :per_page => 10   
    end
  end  

  def show
    @request = Request.find(params[:id])
    render 'show'
  end

  def new
    @request = Request.new
  end

  def edit
  end

  def create
    @request = current_employee.requests.build(params[:request]) 
    @current_date = DateTime.now.to_date 

    if @request.save
      flash[:success] = "Request was successfully created."
      render 'show'
    else
      render 'new'     
    end
  end

  def update
    
    if @request.update_attributes(params[:request])
      flash[:success] = "Request was successfully updated."
      redirect_to request_url(@request)
    else
      render 'edit'
    end
  end

  def destroy
    @request.destroy
    redirect_to root_url
  end

  private
  
  def non_user
     if current_employee.nil?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end

  def correct_employee
      @request = current_employee.requests.find_by_id(params[:id])
      redirect_to root_url if @request.nil?
  end  
end

