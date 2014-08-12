class CreateRequestSkillsController < ApplicationController
  # GET /create_request_skills
  # GET /create_request_skills.json
  def index
    @create_request_skills = CreateRequestSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @create_request_skills }
    end
  end

  # GET /create_request_skills/1
  # GET /create_request_skills/1.json
  def show
    @create_request_skill = CreateRequestSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @create_request_skill }
    end
  end

  # GET /create_request_skills/new
  # GET /create_request_skills/new.json
  def new
    @create_request_skill = CreateRequestSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @create_request_skill }
    end
  end

  # GET /create_request_skills/1/edit
  def edit
    @create_request_skill = CreateRequestSkill.find(params[:id])
  end

  # POST /create_request_skills
  # POST /create_request_skills.json
  def create
    @create_request_skill = CreateRequestSkill.new(params[:create_request_skill])

    respond_to do |format|
      if @create_request_skill.save
        format.html { redirect_to @create_request_skill, notice: 'Create request skill was successfully created.' }
        format.json { render json: @create_request_skill, status: :created, location: @create_request_skill }
      else
        format.html { render action: "new" }
        format.json { render json: @create_request_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /create_request_skills/1
  # PUT /create_request_skills/1.json
  def update
    @create_request_skill = CreateRequestSkill.find(params[:id])

    respond_to do |format|
      if @create_request_skill.update_attributes(params[:create_request_skill])
        format.html { redirect_to @create_request_skill, notice: 'Create request skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @create_request_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /create_request_skills/1
  # DELETE /create_request_skills/1.json
  def destroy
    @create_request_skill = CreateRequestSkill.find(params[:id])
    @create_request_skill.destroy

    respond_to do |format|
      format.html { redirect_to create_request_skills_url }
      format.json { head :no_content }
    end
  end
end
