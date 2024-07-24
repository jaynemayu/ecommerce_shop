# frozen_string_literal: true

module Types
  class CurrentUserType < Types::UserType
    field :current_shop, Types::ShopType, null: true

    def current_shop
      object.shops.first
    end
  end
end
