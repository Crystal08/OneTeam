class ResponsesController < ApplicationController
  
  def index
    @request = Request.find_by_id(params[:request_id])
    @response = Response.all

    respond_to do |format|
      format.html 
      format.json { render json: @responses }
    end
  end


  def show
    @request = Request.find_by_id(params[:request_id])   
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @response }
    end
  end

 
  def new
    @request = Request.find_by_id(params[:request_id])
    @response = @request.responses.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end


  def edit
    @request = Request.find_by_id(params[:request_id])
    @response = Response.find(params[:id])
  end

 
  def create
    @request = Request.find_by_id(params[:request_id])
    @response = @request.responses.build(params[:response])

    respond_to do |format|
      if @response.save
        format.html { redirect_to request_response_path(@request,@response), notice: 'Response was successfully created.' }
        format.json { render json: @response, status: :created, location: @response }
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    @request = Request.find_by_id(params[:request_id])	  
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end
end
