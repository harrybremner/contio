class MessagesController < ApplicationController

  def inbox
  end

  def index
    @project = Project.find(params[:project_id])
    if @project.client == current_user || @project.contractor == current_user
      @message = Message.new
      @user = current_user
    else
      authorization_error
    end
  end

  def destroy
  end

  def create
    @project = Project.find(params[:project_id])
    @message = Message.new(message_params)
    @message.project = @project
    @message.user = current_user
    if @message.save
      ProjectChannel.broadcast_to(
        @project,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "messages/index", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def authorization_error
    redirect_to root_path, alert: 'You are not authorized to see that project'
  end

end
