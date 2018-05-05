class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :complete]
  before_action :authenticate_user!, only: [:edit, :create, :update, :new, :complete ]

  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to index_uncomplete_posts_path
    else
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end


  def complete
    @post.update(completed: true)
    redirect_to index_complete_posts_path
  end

  def index_complete
    @posts = Post.where(completed: true).order(created_at: :desc).page(params[:page]).per(5)
  end

  def index_uncomplete
    @posts = Post.where(completed: false).order(created_at: :desc).page(params[:page]).per(5)
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
