class SelectionsController < ApplicationController
  before_filter :signed_in_employee
  
  def index
    @selection = Selection.all
  end

  def show
    @selection = Selection.find(params[:id])
  end

  def new
    @selection = Selection.new
  end

  def edit 
    @selection = Selection.find(params[:id])
  end

  def create  
    @selection = Selection.new(params[:selection])

    respond_to do |format|
      if @selection.save
        format.html { redirect_to selection_path(@selection), notice: 'Selection was successfully created.' }
        format.json { render json: @selection, status: :created, location: @selection }
      else
        format.html { render action: "new" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @selection = Selection.find(params[:id])

    respond_to do |format|
      if @selection.update_attributes(params[:selection])
        format.html { redirect_to @selection, notice: 'Selection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @selection = Selection.find(params[:id])
    @selection.destroy

    respond_to do |format|
      format.html { redirect_to selections_url }
      format.json { head :no_content }
    end
  end
end
