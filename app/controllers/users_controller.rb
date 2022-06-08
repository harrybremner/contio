class UsersController < ApplicationController
  def show
    @user = current_user
    if @user.is_contractor
      @projects = Project.where(contractor: @user)
    else
      @projects = Project.where(client: @user)
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, status: :see_other
  end
end
