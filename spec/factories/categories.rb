# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Sample Category' }
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
