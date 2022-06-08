class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, status: :see_other
  end
end
