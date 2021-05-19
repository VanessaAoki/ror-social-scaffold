class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_back(fallback_location: new_user_friendship_path)
    else
      render :create
    end
  end

  def update
    friend = User.find(params[:id])
    friendship = friend.friendships.find_by(friend_id: current_user.id)
    if current_user.friend_requests.include?(friend)
      friendship.confirm_friend
      flash[:notice] = 'Friendship was confirmed correctly.'
      redirect_back(fallback_location: user_path)
    else
      flash[:notice] = 'Friendship was not modified.'
      render :update
    end
  end

  def destroy
    friend = User.find(params[:id])
    friendship = friend.friendships.find_by(friend_id: current_user.id)

    flash[:notice] = if friendship.destroy
                       'Friendship was rejected.'
                     else
                       'Some error happened.'
                     end
    redirect_back(fallback_location: user_path)
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id)
  end
end
