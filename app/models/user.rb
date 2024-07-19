class User < ApplicationRecord
  # include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end
end
