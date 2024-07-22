# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :shop_users, dependent: :destroy
  has_many :users, through: :shop_users
  has_many :admins, -> { where(users: { role_id: Role.find_by(level: 10).id }) }, through: :shop_users, source: :user

  validates :name, presence: true, uniqueness: { case_sensitive: false }
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
