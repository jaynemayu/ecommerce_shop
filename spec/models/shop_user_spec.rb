# frozen_string_literal: true

# spec/models/shop_user_spec.rb
require 'rails_helper'

RSpec.describe ShopUser, type: :model do
  let!(:shop) { Shop.create!(name: 'Test Shop') }
  let!(:user) do
    User.create!(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                 password_confirmation: 'password', role: Role.find_by(level: 99))
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      shop_user = ShopUser.new(user:, shop:)
      expect(shop_user).to be_valid
    end

    it 'is not valid without a user' do
      shop_user = ShopUser.new(shop:)
      expect(shop_user).not_to be_valid
      expect(shop_user.errors[:user]).to include('must exist')
    end

    it 'is not valid without a shop' do
      shop_user = ShopUser.new(user:)
      expect(shop_user).not_to be_valid
      expect(shop_user.errors[:shop]).to include('must exist')
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      shop_user = ShopUser.new(user:, shop:)
      expect(shop_user.user).to eq(user)
    end

    it 'belongs to a shop' do
      shop_user = ShopUser.new(user:, shop:)
      expect(shop_user.shop).to eq(shop)
    end
  end
end
