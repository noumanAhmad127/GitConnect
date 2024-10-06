class ProjectsController < ApplicationController
  before_action :set_profile
  before_action :set_project, only: %i[edit update destroy]

  def new
    @project = @profile.projects.new
  end
end
