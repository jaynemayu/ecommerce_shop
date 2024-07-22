# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "ShopName#{n}" }
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
# Indexes
#
#  index_shops_on_name  (name) UNIQUE
#
