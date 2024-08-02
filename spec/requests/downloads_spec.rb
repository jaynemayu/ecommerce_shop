# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Downloads', type: :request do
  let(:shop_admin_role) { create(:role, name: 'admin', level: 10) }
  let(:shop_admin_user) { create(:user, role: shop_admin_role) }
  let(:current_user) { shop_admin_user }
  let(:upload) do
    create(:upload, file: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_img.png'), 'image/png'))
  end

  before do
    sign_in current_user
    ActiveStorage::Current.url_options = { host: 'localhost', port: 3000 }
  end

  describe 'GET /download/:id' do
    context 'when the file exists' do
      it 'downloads the file successfully' do
        get download_path(upload.id)

        expect(response).to have_http_status(:found) # Because it's a redirect to the file URL
        expect(response.headers['Location']).to match(%r{rails/active_storage/blobs})
      end
    end

    context 'when the file does not exist' do
      it 'returns a not found error' do
        get download_path(-1) # Assuming -1 is an ID that does not exist

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body).to have_key('error')
      end
    end
  end
end
