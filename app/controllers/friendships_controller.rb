class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @requests = current_user.requests
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.save
    redirect_to user_url(id: params[:friend_id])
  end

  def update
    @friendship = current_user.friendships.build(friend_id: params[:id], status: true)
    @friendship.save
    @friendship2 = Friendship.find([params[:id].to_i, current_user.id])
    @friendship2.update(status: true)
    redirect_to friendships_path
  end

  def destroy
    @friendship = Friendship.find([params[:id].to_i, current_user.id])
    @friendship.destroy
    redirect_to friendships_path
  end
end