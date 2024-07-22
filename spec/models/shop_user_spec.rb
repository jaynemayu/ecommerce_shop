# frozen_string_literal: true

# spec/models/shop_user_spec.rb
require 'rails_helper'

RSpec.describe ShopUser, type: :model do
  let!(:super_admin_role) do
    return Role.find_by(level: 99) if Role.exists?(level: 99)

    create(:role, name: 'super_admin', level: 99)
  end

  let!(:admin_role) do
    return Role.find_by(level: 10) if Role.exists?(level: 10)

    create(:role, name: 'admin', level: 10)
  end

  let!(:shop) { Shop.create!(name: 'Test Shop') }
  let!(:user) do
    User.create!(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                 password_confirmation: 'password', role: super_admin_role)
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

# == Schema Information
#
# Table name: shop_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  shop_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shop_users_on_shop_id  (shop_id)
#  index_shop_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#  fk_rails_...  (user_id => users.id)
#
