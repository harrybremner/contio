class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = current_user
    if @user.is_contractor
      @projects = Project.where(contractor: @user)
    else
      @projects = Project.where(client: @user)
    end
  end

end
