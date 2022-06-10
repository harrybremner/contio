class ProjectsController < ApplicationController

  def index
    @user = current_user
    # user projects
    if @user.is_contractor
      @projects = Project.where(contractor: @user)
    else
      @projects = Project.where(client: @user)
    end

    # in progress projects
    if @user.is_contractor
      @in_progress_projects = Project.where(contractor: @user, completed: false).count
    else
      @in_progress_projects = Project.where(client: @user, completed: false).count
    end

    # need to make this more
    @in_progress_tasks = Task.where(completed: false).count
    @completed_tasks = Task.where(completed: true).count

    @project = Project.new

    @time = DateTime.parse(Time.new.to_s)

  end

  def show
    #for the show page we only show this if the user has access ie if that project is assigned to them (as the path will be /project/project_id)
      @project = Project.find(params[:id])
      @task = Task.new
      if @project.client == current_user || @project.contractor == current_user
        @user = current_user
        @tasks = Task.all
      else
        authorization_error
      end
  end

  def create
    @project = Project.new(project_params)
    @project.contractor = current_user
    @project.client_id = 69
    if @project.save!
      redirect_to projects_path(@projects)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end


  private

  def project_params
    params.require(:project).permit(:name, :budget, :start_date, :end_date,
      :total_price, :contractor, :client, :description)
  end

  def authorization_error
    redirect_to root_path, alert: 'You are not authorized to see that project'
  end

end
