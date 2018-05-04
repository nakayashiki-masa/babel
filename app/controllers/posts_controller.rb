class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :complete]

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to index_uncomplete_posts_path
  end

  def edit
  end


  def complete
    @post.update(completed: true)
    redirect_to index_complete_posts_path
  end

  def index_complete
    @posts = Post.where(completed: true)
  end

  def index_uncomplete
    @posts = Post.where(completed: false)
  end

  def update
    @post_new = Post.new(post_params)
    if @post.update(body: @post.body + @post_new.body)
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :completed)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
