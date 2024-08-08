# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateShop, type: :request do
  let(:mutation) { Rails.root.join('spec/graphql_files/mutations/create_shop_mutation.graphql').read }

  let(:variables) do
    {
      shopName: 'New Shop',
      adminEmail: 'newadmin@example.com',
      adminFirstName: 'New',
      adminLastName: 'Admin'
    }
  end

  let!(:super_admin_role) do
    return Role.find_by(level: 99) if Role.exists?(level: 99)

    create(:role, name: 'super_admin', level: 99)
  end

  let!(:admin_role) do
    return Role.find_by(level: 10) if Role.exists?(level: 10)

    create(:role, name: 'admin', level: 10)
  end

  let(:super_admin_user) { create(:user, role_id: super_admin_role.id) }
  let(:current_user) { super_admin_user }

  before do
    sign_in current_user
  end

  it 'creates a shop and an admin user' do
    post '/graphql', params: { query: mutation, variables: }, as: :json

    res_data = JSON.parse(response.body, symbolize_names: true).dig(:data, :createShop)

    expect(res_data[:shop][:name]).to eq(variables[:shopName])
    expect(res_data[:adminUser][:email]).to eq(variables[:adminEmail])
    expect(res_data[:adminUser][:firstName]).to eq(variables[:adminFirstName])
    expect(res_data[:adminUser][:lastName]).to eq(variables[:adminLastName])
    expect(res_data[:error]).to be_nil
    expect(response).to have_http_status(:success)

    shop_record = Shop.find_by(id: res_data[:shop][:id])
    expect(shop_record).to be_present
    expect(shop_record.name).to eq(variables[:shopName])

    shop_admin_record = User.find_by(id: res_data[:adminUser][:id])
    expect(shop_admin_record).to be_present
    expect(shop_admin_record.email).to eq(variables[:adminEmail])
    expect(shop_admin_record.first_name).to eq(variables[:adminFirstName])
    expect(shop_admin_record.last_name).to eq(variables[:adminLastName])

    shop_and_shop_admin_relationship = ShopUser.find_by(shop_id: shop_record.id, user_id: shop_admin_record.id)
    expect(shop_and_shop_admin_relationship).to be_present

    expect(res_data[:error]).to be_nil
  end

  it 'returns an error if the shop name already exists' do
    create(:shop, name: variables[:shopName])
    post '/graphql', params: { query: mutation, variables: }, as: :json

    res_data = JSON.parse(response.body, symbolize_names: true).dig(:data, :createShop)
    res_error = res_data[:error]

    expect(res_error).to be_present
    expect(res_error[:code]).to eq(422)
    expect(res_error[:type]).to eq('INVALID')
    expect(res_error[:message]).to eq('Shop name is already taken')
  end

  it 'returns an error if the email is already taken' do
    create(:user, email: variables[:adminEmail], role: admin_role)
    post '/graphql', params: { query: mutation, variables: }, as: :json

    res_data = JSON.parse(response.body, symbolize_names: true).dig(:data, :createShop)
    res_error = res_data[:error]

    expect(res_error).to be_present
    expect(res_error[:code]).to eq(422)
    expect(res_error[:type]).to eq('INVALID')
    expect(res_error[:message]).to eq('Email is already taken')
  end
end
