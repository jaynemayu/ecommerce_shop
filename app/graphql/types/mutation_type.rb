# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_shop, mutation: Mutations::CreateShop
  end
end
