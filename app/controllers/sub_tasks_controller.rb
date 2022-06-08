class SubTasksController < ApplicationController

  def show
    @user = current_user
    @task = Task.find(params[:task_id])
    @sub_task = SubTask.find(params[:id])
  end

  def update
    @sub_task = SubTask.find(params[:id])
    if @sub_task.update(sub_task_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @task = Task.find(params[:task_id])
    @sub_task = SubTask.new(sub_task_params)
    @sub_task.user = current_user
    @sub_task.task = @task
    if @sub_task.save
      redirect_to task_sub_task_path(id: @sub_task.id, task_id: @task.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @sub_task = SubTask.find(params[:id])
    @sub_task.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def sub_task_params
    params.require(:sub_task).permit(:completed, :name, :description)
  end
end
