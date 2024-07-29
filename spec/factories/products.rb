# frozen_string_literal: true

# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { 'Sample Product' }
    slug { 'sample-product' }
    status { 1 }
    price { '30.00 USD' }
    product_type { 'physical' }
    description { 'Sample description' }
    association :shop, factory: :shop
    association :creator, factory: :user
    association :updater, factory: :user
  end
end

# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  status       :integer          default("published"), not null
#  price        :decimal(10, 2)   not null
#  product_type :string           not null
#  description  :text
#  creator_id   :bigint           not null
#  updater_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_products_on_creator_id  (creator_id)
#  index_products_on_updater_id  (updater_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (updater_id => users.id)
#
