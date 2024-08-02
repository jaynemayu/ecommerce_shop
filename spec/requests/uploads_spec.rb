# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Uploads', type: :request do
  let(:shop_admin_role) { create(:role, name: 'admin', level: 10) }
  let(:shop_admin_user) { create(:user, role: shop_admin_role) }
  let(:current_user) { shop_admin_user }

  before do
    sign_in current_user
    ActiveStorage::Current.url_options = { host: 'localhost', port: 3000 }
  end

  describe 'POST /upload' do
    let(:valid_file) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test_img.png'), 'image/png') }

    context 'with a valid file' do
      it 'uploads the file and returns the URL' do
        post upload_path, params: { file: valid_file }

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to have_key('url')
      end
    end

    context 'without a file' do
      it 'returns an error' do
        post upload_path

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to have_key('error')
      end
    end
  end
end
