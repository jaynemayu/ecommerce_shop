# frozen_string_literal: true

# app/controllers/downloads_controller.rb
class DownloadsController < ApplicationController
  def show
    @upload = Upload.find_by(id: params[:id])
    if @upload&.file&.attached?
      redirect_to rails_blob_url(@upload.file, disposition: 'attachment')
    else
      render json: { error: 'File not found' }, status: :not_found
    end
  end
end
