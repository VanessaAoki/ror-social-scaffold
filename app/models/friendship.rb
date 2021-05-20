class Friendship < ApplicationRecord
  self.primary_key = :user_id, :friend_id
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
