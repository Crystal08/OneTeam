class CurrentSkillsController < ApplicationController
  # GET /current_skills
  # GET /current_skills.json
  def index
    @current_skills = CurrentSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @current_skills }
    end
  end

  # GET /current_skills/1
  # GET /current_skills/1.json
  def show
    @current_skill = CurrentSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @current_skill }
    end
  end

  # GET /current_skills/new
  # GET /current_skills/new.json
  def new
    @current_skill = CurrentSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @current_skill }
    end
  end

  # GET /current_skills/1/edit
  def edit
    @current_skill = CurrentSkill.find(params[:id])
  end

  # POST /current_skills
  # POST /current_skills.json
  def create
    @current_skill = CurrentSkill.new(params[:current_skill])

    respond_to do |format|
      if @current_skill.save
        format.html { redirect_to @current_skill, notice: 'Current skill was successfully created.' }
        format.json { render json: @current_skill, status: :created, location: @current_skill }
      else
        format.html { render action: "new" }
        format.json { render json: @current_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /current_skills/1
  # PUT /current_skills/1.json
  def update
    @current_skill = CurrentSkill.find(params[:id])

    respond_to do |format|
      if @current_skill.update_attributes(params[:current_skill])
        format.html { redirect_to @current_skill, notice: 'Current skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @current_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_skills/1
  # DELETE /current_skills/1.json
  def destroy
    @current_skill = CurrentSkill.find(params[:id])
    @current_skill.destroy

    respond_to do |format|
      format.html { redirect_to current_skills_url }
      format.json { head :no_content }
    end
  end
end
