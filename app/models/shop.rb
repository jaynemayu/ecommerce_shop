# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :shop_users, dependent: :destroy
  has_many :users, through: :shop_users
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
