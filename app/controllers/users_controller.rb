class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
    @pending_requests = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = current_user.friend_requests
    @friendship = Friendship.new
  end
end
