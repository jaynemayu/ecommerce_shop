# frozen_string_literal: true

# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product, creator: user, updater: user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a slug' do
      product.slug = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a status' do
      product.status = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a type' do
      product.product_type = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a description' do
      product.description = nil
      expect(product).to be_valid
    end
  end

  context 'associations' do
    it 'belongs to a creator' do
      expect(product.creator).to eq(user)
    end

    it 'belongs to an updater' do
      expect(product.updater).to eq(user)
    end

    it 'has and belongs to many categories' do
      category = create(:category)
      product.categories << category
      expect(product.categories).to include(category)
    end
  end
end

# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  status       :integer          default("unpublished"), not null
#  price        :decimal(10, 2)   not null
#  product_type :string           not null
#  description  :text
#  shop_id      :bigint           not null
#  creator_id   :bigint           not null
#  updater_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_products_on_creator_id  (creator_id)
#  index_products_on_shop_id     (shop_id)
#  index_products_on_updater_id  (updater_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (shop_id => shops.id)
#  fk_rails_...  (updater_id => users.id)
#
