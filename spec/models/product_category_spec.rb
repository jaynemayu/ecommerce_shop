# frozen_string_literal: true

# spec/models/product_category_spec.rb

require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  let(:product) { create(:product) }
  let(:category) { create(:category) }
  let(:product_category) { build(:product_category, product:, category:) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(product_category).to be_valid
    end

    it 'is not valid without a product' do
      product_category.product = nil
      expect(product_category).to_not be_valid
    end

    it 'is not valid without a category' do
      product_category.category = nil
      expect(product_category).to_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: product_categories
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_product_categories_on_category_id  (category_id)
#  index_product_categories_on_product_id   (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (product_id => products.id)
#
