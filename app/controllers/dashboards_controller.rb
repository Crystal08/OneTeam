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

  
end
