class ProjectsController < ApplicationController

  def index
    @user = current_user
    # user projects
    if @user.is_contractor
      @projects = Project.where(contractor: @user)

    else
      @projects = Project.where(client: @user)
    end

    @tasks = Task.where(project: @projects)

    # in progress projects
    if @user.is_contractor
      @in_progress_projects = Project.where(contractor: @user, completed: false).count
    else
      @in_progress_projects = Project.where(client: @user, completed: false).count
    end

    # in progress tasks and completed tasks
    @completed_tasks = @tasks.completed.count
    # @tasks.each do |task|
    #   if task.completed?
    #     @completed_tasks += 1
    #   end
    @in_progress_tasks = @tasks.count - @completed_tasks


    @project = Project.new
    @time = DateTime.parse(Time.new.to_s)
    @clients = User.where(is_contractor: false)

  end

  def show
    #for the show page we only show this if the user has access ie if that project is assigned to them (as the path will be /project/project_id)
      @project = Project.find(params[:id])
      @task = Task.new
      @time = DateTime.parse(Time.new.to_s)
      if @project.client == current_user || @project.contractor == current_user
        @tasks = Task.all
      else
        authorization_error
      end

      @in_progress_tasks = (@project.tasks.where(completed: false).count.to_f / @project.tasks.count.to_f) * 100
      @completed_tasks = (@project.tasks.where(completed: true).count.to_f / @project.tasks.count.to_f) * 100
  end

  def create
    @project = Project.new(project_params)
    @project.contractor = current_user
    # @project.client = User.find(project_params[:client_id])
    if @project.save
      p "hello from create method"
      redirect_to projects_path()
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end


  private

  def completed_tasks
    if task.sub_tasks.where(completed: true).count == task.sub_tasks.count
      task.completed == true
    end
  end

  def project_params
    params.require(:project).permit(:name, :budget, :start_date, :end_date, :contractor_id, :client_id, :description)
  end

  def authorization_error
    redirect_to root_path, alert: 'You are not authorized to see that project'
  end

end
