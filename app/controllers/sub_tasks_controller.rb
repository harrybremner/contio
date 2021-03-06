class SubTasksController < ApplicationController

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
    @sub_task.task = @task
    if @sub_task.save
      redirect_to task_path(@task)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @sub_task = SubTask.find(params[:id])
    @sub_task.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  def toggle
    @sub_task = SubTask.find(params[:id])
    @sub_task.update(completed: params[:completed])
    

    render json: { message: "Success" }
  end

  private

  def sub_task_params
    params.require(:sub_task).permit(:name, :description, :completed)
  end

  def authorization_error
    redirect_to root_path, alert: 'You are not authorized to see that project'
  end

end
