require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(id: 1, content: 'Hello World!', user_id: 1) }
  let!(:like1) { Like.new(user_id: 1, post_id: 1) }
  let!(:like2) { Like.new(user_id: 1, post_id: 1) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Validations' do
    it 'Is valid.' do
      user.save
      post.save
      expect(like1).to be_valid
    end

    it 'Must not be duplicated.' do
      like1.save
      expect(like2).to_not be_valid
    end
  end
end
