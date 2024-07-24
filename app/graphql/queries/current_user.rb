# frozen_string_literal: true

module Queries
  class CurrentUser < GraphQL::Schema::Resolver
    type Types::CurrentUserType, null: false

    def resolve
      context[:current_user]
    end
  end
end
