class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new(friendship_params)
  end

  def create
    @friendship = current_user.friendships.new(friendship_params)

    if @friendship.save
      redirect_to users_path, notice: 'Friend request sent.'
    else
      render 'new'
    end
  end

  def confirm
    friendship = Friendship.find(params[:id])
    friendship.status = true
    friendship.save
    redirect_to users_path
  end

  def reject
    friendship = Friendship.find(params[:id])
    friendship.status = false
    user = User.find(friendship.user_id)
    friend = User.find(friendship.friend_id)
    Friendship.where(user: user, friend: friend).first.delete
    friendship.save
    redirect_to users_path
  end

  def destroy
    friendship = friendship.find_by(id: params[:id], user: current_user, friend_id: params[:user_id])
    if friendship
      friendship.destroy
      redirect_to posts_path, notice: "You are not friends with #{friend.name} anymore."
    else
      redirect_to posts_path, alert: 'You cannot disfriendship post that you did not friendship before.'
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status, :id)
  end
end
