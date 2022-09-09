class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.includes(:author).where(author: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)

    if @post.save
      flash[:notice] = 'New post created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:alert] = 'Post could not be created'
      render action: :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.author), notice: 'Post deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
