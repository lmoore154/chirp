class ApplicationController < ActionController::API

  private

  def current_user
    @current_user ||= User.find_by(token: params[:token]) if params[:token]
  end

  def require_user
    render json: ["You must be logged in to do that."], status: 401 unless current_user
  end
end
