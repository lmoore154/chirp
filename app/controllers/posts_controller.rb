class PostsController < ApplicationController

  before_action :require_user, only: [:create, :timeline]

  def index
    posts = Post.all#.paginate(page: params[:page], per_page: 10)
    render json: posts
  end

  def show
    render json: Post.find(params[:id])
  end

  def timeline
    # post_list = current_user.posts
    # current_user.followees(User).each do |u|
    #   post_list += u.posts
    # end
    user_timeline = Post.timeline(current_user)
    render json: user_timeline
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: 400
    end
  end

  # def search
  #   post = Post.where("body LIKE ?", "%#{params[:body]}%")
  #   render json: post
  # end

  private

  def post_params
    params.permit(:body)
  end

end
