class ProjectsController < ApplicationController

  def index
    @user = current_user
    # user projects
    @projects = Project.where(contractor: @user)

    # in progress projects
    @in_progress_projects = Project.where(contractor: @user, completed: false).count

    # need to make this more
    @in_progress_tasks = Task.where(completed: false).count
    @completed_tasks = Task.where(completed: true).count

    @project = Project.new

    @time = DateTime.parse(Time.new.to_s)

  end

  def show
      # @projects = Project.where(contractor: current_user)
      # @project = @projects.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.contractor = current_user
    @project.client_id = 33
    if @project.save!
      redirect_to projects_path(@projects)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def messages_index
  end

  private

  def project_params
    params.require(:project).permit(:name, :budget, :start_date, :end_date,
      :total_price, :contractor, :client, :description)
  end

end
