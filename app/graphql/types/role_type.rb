# frozen_string_literal: true

module Types
  class RoleType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :level, Integer, null: false
  end
end
