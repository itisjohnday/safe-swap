
class PostsController < ApplicationController
  before_action :set_device
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.all
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.device_id = @device.id
    @post.user_id = current_user.id

    if @post.save
      redirect_to device_posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(device_params)
      redirect_to @post, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @post.device.sold? != true
      @post.destroy
    end

    redirect_to posts_url, notice: 'Location was successfully destroyed.'
  end

  private

  def set_device
    @device = Device.find(params[:device_id])
  end

  def post_params
    params.require(:post).permit(:content, :device_id, :user_id)
  end
end