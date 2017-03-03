class UsersController < ApplicationController

  before_action :require_user, only: [:follow]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, serializer: UserExpandedSerializer
    else
      render json: @user.errors.full_messages, status: 401
    end
  end

  def follow
    @user = User.find_by(id: params[:id])
    if current_user.follows?(@user)
      render json: ["#{current_user.username} is already following #{@user.username}."]
    else
      current_user.follow!(@user)
      render json: ["#{current_user.username} is now following #{@user.username}."]
    end
  end

  def unfollow
    @user = User.find_by(id: params[:id])
    current_user.unfollow!(@user)
    render json: ["#{current_user.username} stopped following #{@user.username}."]
  end

  def profile
    user = User.find_by(id: params[:id])
    render json: user, serializer: UserProfileSerializer
  end

  # def search
  #   user = User.where("username LIKE ?", "%#{params[:username]}%" )    AND or OR for additional fields?
  #   render json: post
  # end

  private

  def user_params
    params.permit(:username, :first_name, :last_name, :password, :email, :photo_url)
  end

end
