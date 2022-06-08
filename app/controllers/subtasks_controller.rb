class SubtasksController < ApplicationController

  def show
    @user = current_user
    @task = Task.find(params[:task_id])
    @subtask = Subtask.find(params[:id])
  end

  def update
    @subtask = Subtask.find(params[:id])
    if @subtask.update(subtask_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @task = Task.find(params[:task_id])
    @subtask = Subtask.new(subtask_params)
    @subtask.user = current_user
    @subtask.task = @task
    if @subtask.save
      redirect_to task_subtask_path(id: @subask.id, task_id: @task.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @subtask = Subtask.find(params[:id])
    @subtask.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def subtask_params
    params.require(:subtask).permit(:completed, :name, :description)
  end

end
