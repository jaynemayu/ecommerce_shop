# frozen_string_literal: true

# spec/models/shop_spec.rb
require 'rails_helper'

RSpec.describe Shop, type: :model do
  let!(:shop) { Shop.create!(name: 'Test Shop') }

  context 'validations' do
    it 'is valid with a name' do
      expect(shop).to be_valid
    end

    it 'is not valid without a name' do
      shop.name = nil
      expect(shop).not_to be_valid
      expect(shop.errors[:name]).to include("can't be blank")
    end

    it 'is not valid with a duplicate name' do
      Shop.create!(name: 'Duplicate Shop')
      new_shop = Shop.new(name: 'Duplicate Shop')
      expect(new_shop).not_to be_valid
      expect(new_shop.errors[:name]).to include('has already been taken')
    end
  end

  context 'associations' do
    it 'has many shop_users' do
      association = described_class.reflect_on_association(:shop_users)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many users through shop_users' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:shop_users)
    end
  end
end

# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
