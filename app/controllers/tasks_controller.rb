class TasksController < ApplicationController

  def show
    #for the show page we only show this if the user has access ie if that project is assigned to them (as the path will be /project/project_id)
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @sub_task = SubTask.new
    @sub_tasks = SubTask.where(task: @task)
    if @project.client == current_user || @project.contractor == current_user
      @user = current_user
    else
      authorization_error
    end
    @completed_tasks = @sub_tasks.select {|subtask| subtask.completed }
    @completed_tasks = @completed_tasks.length
    @uncompleted_tasks = @sub_tasks.length - @completed_tasks
    if @uncompleted_tasks == 0
      @percentage = 100.0
    else
      if @completed_tasks == 0
        @percentage = 0.0
      else
        @percentage = (@completed_tasks.to_f / @sub_tasks.length.to_f ) * 100
      end
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new(task_params)
    @task.project = @project
    if @task.save
      redirect_to project_path(@project)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to user_path(current_user)
    else
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to task_path(@task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :price, :start_date, :end_date, :priority)
  end

  def authorization_error
    redirect_to root_path, alert: 'You are not authorized to see that project'
  end

end
