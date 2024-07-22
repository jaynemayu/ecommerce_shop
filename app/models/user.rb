# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  has_many :shop_users, dependent: :destroy
  has_many :shops, through: :shop_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end
end
