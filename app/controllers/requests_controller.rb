class RequestsController < ApplicationController
  before_filter :signed_in_employee
  before_filter :correct_employee, only: [:edit, :update, :destroy]

  def index
    @requests = Request.paginate :page => params[:page], :per_page => 10
    
    if signed_in?
      Request.where("employee_id = ?", id)  
    else  
      render 'index'
    end
  end  

  def show
    @request = Request.find(params[:id])
    render 'show'
  end

  def new
    @request = Request.new
    render 'new'
  end

  def edit
  end

  def create
    @request = current_employee.requests.build(params[:request]) 

    if @request.save
      flash[:success] = "Request was successfully created."
      redirect_to root_url
    else
      render 'new'     
    end
  end

  def update
    
    if @request.update_attributes(params[:request])
      flash[:success] = "Request was successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @request.destroy
    redirect_to root_url
  end

  private

    def correct_employee
      @request = current_employee.requests.find_by_id(params[:id])
      redirect_to root_url if @request.nil?
    end  
end

