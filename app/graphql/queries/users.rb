module Queries
  class Users < GraphQL::Schema::Resolver
    type [Types::UserType], null: false

    def resolve
      # context[:current_user]
      
      User.all
    end
  end
end