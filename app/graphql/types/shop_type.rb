# frozen_string_literal: true

# app/graphql/types/shop_type.rb

module Types
  class ShopType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :admins, [Types::UserType], null: false
  end
end
