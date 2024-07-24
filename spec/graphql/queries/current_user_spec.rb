# frozen_string_literal: true

# spec/graphql/queries/current_user_spec.rb
require 'rails_helper'

RSpec.describe 'CurrentUser', type: :request do
  let(:query) do
    Rails.root.join('spec/graphql_files/queries/current_user_query.graphql').read
  end

  let(:super_admin_role) { create(:role, name: 'super_admin', level: 99) }
  let(:admin_role) { create(:role, name: 'admin', level: 10) }

  let(:super_admin_user) { create(:user, role: super_admin_role) }
  let(:admin_user) { create(:user, role: admin_role) }
  let(:shop) { create(:shop) }

  before do
    sign_in current_user
    create(:shop_user, user: admin_user, shop:)
  end

  context 'when user is a super admin' do
    let(:current_user) { super_admin_user }

    it 'returns the current user without current shop' do
      post '/graphql', params: { query: }, as: :json

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:currentUser]

      expect(data[:id]).to eq(current_user.id.to_s)
      expect(data[:email]).to eq(current_user.email)
      expect(data[:role][:level]).to eq(99)
      expect(data[:currentShop]).to be_nil
      expect(response).to have_http_status(:success)
    end
  end

  context 'when user is an admin' do
    let(:current_user) { admin_user }

    it 'returns the current user with current shop' do
      post '/graphql', params: { query: }, as: :json

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:currentUser]

      expect(data[:id]).to eq(current_user.id.to_s)
      expect(data[:email]).to eq(current_user.email)
      expect(data[:role][:level]).to eq(10)
      expect(data[:currentShop][:id]).to eq(shop.id.to_s)
      expect(response).to have_http_status(:success)
    end
  end
end
