require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(content: 'Hello World!', user_id: 1) }

  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'Validations' do
    it 'Is valid with content.' do
      user.save
      expect(post).to be_valid
    end

    it 'Content must be 1000 characters or less.' do
      str = ' '
      1002.times { str << 'a' }
      post.content = str
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end
end
