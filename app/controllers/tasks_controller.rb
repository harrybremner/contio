class TasksController < ApplicationController

  def index
    authorize @task
    @tasks = Task.all
  end

  def show
    @user = current_user
    @task = Task.find(params[:task_id])
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.user = @user
    @task.save
    redirect_to task_path(@task)
  end

  def edit
    authorize @task
    @task = Task.find(params[:id])
  end

  def update
    authorize @task
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:task).permit(:name, :description,
                                 :price, :start_date, :end_date,
                                 :completed, :priority, :approved)
  end
end
