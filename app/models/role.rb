# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  level      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
