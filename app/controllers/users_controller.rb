class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @is_me = current_user.id.to_i != params[:id].to_i
    @friend = current_user.friend? params[:id]
    @posts = @user.posts.ordered_by_most_recent
  end
end
