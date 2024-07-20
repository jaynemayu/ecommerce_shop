# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :shop_users, dependent: :destroy
  has_many :users, through: :shop_users
end
