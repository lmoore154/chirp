class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])&.authenticate(params[:password])
    if @user
      render json: @user, serializer: UserExpandedSerializer
    else
      render json: ["Incorrect login, try again."], status: 401
    end
  end



end
