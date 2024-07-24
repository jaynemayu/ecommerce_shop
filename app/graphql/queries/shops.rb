# frozen_string_literal: true

module Queries
  class Shops < GraphQL::Schema::Resolver
    description 'Get all shops with pagination'

    argument :page, Integer, required: false
    argument :per_page, Integer, required: false

    type [Types::ShopType], null: false

    def resolve(page: 1, per_page: 20)
      page = page.to_i
      page = 1 if page < 1
      per_page = per_page.to_i
      per_page = 20 if per_page < 1

      Shop.includes(admins: :role)
          .page(page)
          .per(per_page)
    end
  end
end
