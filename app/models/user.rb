class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :confirmed_friendships, dependent: :destroy

  # pending_friends
  has_many :pending_friendships, -> { where status: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  # friend_requests
  has_many :inverted_friendships, -> { where status: nil }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :requests, through: :inverted_friendships, source: :user

  def friends_without_status
    friends.select(:friend_id)
  end

  def request?(user_id)
    friend = requests.where("id = #{user_id}")
    return false if friend.empty?

    true
  end

  def friend?(user_id)
    friend = pending_friends.where("id = #{user_id}")
    return nil unless friend.empty?

    friend = friends.where("id = #{user_id}")
    return true unless friend.empty?

    false
  end
end
