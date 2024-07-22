# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries', type: :request do
  let(:query) do
    Rails.root.join('spec/graphql_files/queries/shops_query.graphql').read
  end

  let(:variables) do
    {
      page: 1,
      perPage: 20
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

  context 'when only one shop exists' do
    let!(:role) { create(:role, level: 10) }
    let!(:shop) { create(:shop) }
    let!(:shop_admin) do
      user = create(:user, role: admin_role)
      create(:shop_user, shop:, user:)

      user
    end

    it 'returns shops with admin details' do
      post '/graphql', params: { query:, variables: }, as: :json

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:shops]

      expect(data).to be_an(Array)
      expect(data.first[:name]).to eq(shop.name)

      admin_user = data.first[:admins].first
      expect(admin_user[:firstName]).to eq(shop_admin.first_name)
      expect(admin_user[:lastName]).to eq(shop_admin.last_name)
      expect(response).to have_http_status(:success)
    end
  end

  it 'paginates results' do
    create_list(:shop, 25)

    post '/graphql', params: { query:, variables: { page: 2, perPage: 20 } }, as: :json
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data][:shops]

    expect(data.size).to eq(5)
  end

  it 'defaults to the first page if no page is provided' do
    create_list(:shop, 25)

    post '/graphql', params: { query: }, as: :json
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data][:shops]

    expect(data.size).to eq(20)
  end
end
