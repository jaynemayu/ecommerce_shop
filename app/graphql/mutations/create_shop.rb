# frozen_string_literal: true

# app/graphql/mutations/create_shop.rb

module Mutations
  class CreateShop < BaseMutation
    argument :shop_name, String, required: true
    argument :admin_email, String, required: true
    argument :admin_first_name, String, required: true
    argument :admin_last_name, String, required: true

    field :shop, Types::ShopType, null: false
    field :admin_user, Types::UserType, null: false

    def resolve(args)
      validate_uniqueness(args[:admin_email], args[:shop_name])

      admin_user = create_admin_user(args[:admin_email], args[:admin_first_name], args[:admin_last_name])
      shop = Shop.create!(name: args[:shop_name])
      shop.admins << admin_user

      { shop:, admin_user: }
    rescue ActiveRecord::RecordInvalid => e
      raise GraphQL::ExecutionError, e.message
    end

    private

    def validate_uniqueness(email, shop_name)
      if User.exists?(email:)
        raise GraphQL::ExecutionError, 'Email is already taken'
      elsif Shop.exists?(name: shop_name)
        raise GraphQL::ExecutionError, 'Shop name is already taken'
      end
    end

    def create_admin_user(email, first_name, last_name)
      admin_role = Role.find_by(level: 10)
      raise GraphQL::ExecutionError, 'Admin role not found' if admin_role.nil?

      User.create!(
        email:,
        first_name:,
        last_name:,
        role_id: admin_role.id,
        password: 'aA123456789',
        password_confirmation: 'aA123456789'
      )
    end
  end
end
