class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :complete]
  before_action :authenticate_user!, only: [:edit, :create, :update, :new, :complete, :review_create, :show ]

  def index
  end

  def show
    @review = Review.new
  end

  def about
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post_user = PostUser.new(post_id: @post.id, user_id: current_user.id)
      @post_user.save
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
    @posts = Post.where(completed: true).order(created_at: :desc).page(params[:page]).per(4)
  end

  def index_uncomplete
    @posts = Post.where(completed: false).order(created_at: :desc).page(params[:page]).per(4)
  end

  def update
    @post_new = Post.new(post_params)
    if @post.update(body: @post.body + @post_new.body)
      @post_users = PostUser.find_or_create_by(post_id: @post.id, user_id: current_user.id)
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages
      render :show
    end
  end

  def review_create
  @review = Review.new(review_params)
    if @review.save
      redirect_to post_path(@review.post)
    else
      redirect_to post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def review_params
    params.require(:review).permit(:body, :post_id, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
