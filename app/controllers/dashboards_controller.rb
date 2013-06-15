class DashboardsController < ApplicationController

  def requests_overview
    @dashboard = Dashboard.new
  end
  
  def skills_overview
    @dashboard = Dashboard.new
  end

  def guest_developers_overview
    @dashboard = Dashboard.new
  end    

  def index
    @dashboard = Dashboard.new
  end

  def show
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  def new
   @dashboard = Dashboard.new
  end

  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  def create
    @dashboard = Dashboard.new(params[:dashboard])

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        format.html { render action: "new" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
  end
end
