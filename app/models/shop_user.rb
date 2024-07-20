# frozen_string_literal: true

class ShopUser < ApplicationRecord
  belongs_to :user
  belongs_to :shop
end
