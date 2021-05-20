class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships

  has_many :confirmed_friendships, -> { where status: true }, class_name: "Friendship"
  has_many :friends, through: :confirmed_friendships

  # pending_friends
  has_many :pending_friendships, -> { where status: nil }, class_name: "Friendship", foreign_key: "user_id"
  has_many :pending_friends, through: :pending_friendships, source: :friend

  #friend_requests
  has_many :inverted_friendships, -> { where status: nil }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :requests, through: :inverted_friendships, source: :user

  def friends_without_status
    self.friends.select(:friend_id)
  end

  def request?(user_id)
    friend = self.requests.where("id = #{user_id}")
    return false if friend.empty?
    true
  end

  def friend?(user_id)
    friend = self.pending_friends.where("id = #{user_id}")
    return nil if !friend.empty?
    friend = self.friends.where("id = #{user_id}")
    return true if !friend.empty?
    false
  end
end