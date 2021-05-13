require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(id: 1, content: 'Hello World!', user_id: 1) }
  let!(:comment) { Comment.new(content: 'Hello!', user_id: 1, post_id: 1) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Comment Validations' do
    it 'Is valid with content.' do
      user.save
      post.save
      expect(comment).to be_valid
    end

    it 'Content must be 200 characters or less.' do
      str = ' '
      202.times { str << 'a' }
      post.content = str
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end
end