# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
