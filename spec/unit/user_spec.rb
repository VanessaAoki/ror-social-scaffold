require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }

  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
  end

  describe 'Validations' do
    it 'Is valid with name.' do
      expect(user).to be_valid
    end

    it 'Name must be 20 characters or less.' do
      user.name = 'Vanessa Sakamoto Aoki da Silva'
      expect(user).to_not be_valid
    end

    it 'Name must be present.' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end