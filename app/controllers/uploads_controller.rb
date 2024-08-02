# frozen_string_literal: true

# app/controllers/uploads_controller.rb

class UploadsController < ApplicationController
  def create
    file = params[:file]
    if file
      ActiveStorage::Current.url_options = { host: request.host_with_port }
      @upload = Upload.create!(file:)
      render json: { url: url_for(@upload.file) }, status: :ok
    else
      render json: { error: 'No file provided' }, status: :unprocessable_entity
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
