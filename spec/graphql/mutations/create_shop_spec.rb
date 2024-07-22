# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateShop, type: :request do
  let(:mutation) do
    Rails.root.join('spec/graphql_files/mutations/create_shop_mutation.graphql').read
  end

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

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data][:createShop]

    expect(data[:shop][:name]).to eq(variables[:shopName])
    expect(data[:adminUser][:email]).to eq(variables[:adminEmail])
    expect(data[:adminUser][:firstName]).to eq(variables[:adminFirstName])
    expect(data[:adminUser][:lastName]).to eq(variables[:adminLastName])
    expect(response).to have_http_status(:success)
  end

  it 'returns an error if the shop name already exists' do
    create(:shop, name: variables[:shopName])
    post '/graphql', params: { query: mutation, variables: }, as: :json

    json = JSON.parse(response.body, symbolize_names: true)
    errors = json[:errors]

    expect(errors).to be_present
    expect(errors.first[:message]).to eq('Shop name is already taken')
  end

  it 'returns an error if the email is already taken' do
    create(:user, email: variables[:adminEmail], role: admin_role)
    post '/graphql', params: { query: mutation, variables: }, as: :json

    json = JSON.parse(response.body, symbolize_names: true)
    errors = json[:errors]

    expect(errors).to be_present
    expect(errors.first[:message]).to eq('Email is already taken')
  end
end
