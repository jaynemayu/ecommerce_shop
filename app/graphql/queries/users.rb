# frozen_string_literal: true

module Queries
  class Users < GraphQL::Schema::Resolver
    type [Types::UserType], null: false

    def resolve
      User.all
    end
  end
end
