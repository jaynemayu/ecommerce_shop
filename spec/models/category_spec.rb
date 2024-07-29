# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  let(:product) { create(:product) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).to_not be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'has many product_categories' do
      assoc = described_class.reflect_on_association(:product_categories)
      expect(assoc.macro).to eq :has_many
    end

    it 'has many products through product_categories' do
      assoc = described_class.reflect_on_association(:products)
      expect(assoc.macro).to eq :has_many
    end

    it 'destroys dependent product_categories' do
      category.products << product
      expect { category.destroy }.to change { ProductCategory.count }.by(-1)
    end
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
