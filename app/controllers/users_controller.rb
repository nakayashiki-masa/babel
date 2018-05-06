class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(4)
  end
end
