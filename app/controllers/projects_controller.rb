class ProjectsController < ApplicationController
  before_action :set_profile
  before_action :set_project, only: %i[show edit update destroy]

  def show; end

  def new
    @project = @profile.projects.new
  end

  def create
    @project = @profile.projects.new(project_params)
    if @project.save
      redirect_to profile_path(@profile), noyice: 'Project Created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to profile_path(@profile), notice: 'Project Updated'
    else
      render :edit, unprocessable_entity
    end
  end

  def destroy
    @project.destroy

    redirect_to profile_path(@profile), status: :see_other, notice: 'Project Deleted'
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_project
    @project = @profile.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :demo_link, images: [])
  end
end
