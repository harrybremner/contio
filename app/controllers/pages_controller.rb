class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = current_user
    @hide_mobile_footer = true
  end

  def calendar
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    if current_user.is_contractor?
      @projects = current_user.projects_as_contractor
    else
      @projects = current_user.projects_as_client
    end
    # For a monthly view:
    @projects = @projects.where(start_date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
