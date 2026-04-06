# frozen_string_literal: true

class UploadsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    filename = params[:filename]
    file_path = Rails.public_path.join('uploads', filename)

    if File.exist?(file_path)
      send_file file_path, type: 'image/jpeg', disposition: 'inline'
    else
      Rails.logger.error "File not found: #{file_path}"
      head :not_found
    end
  end
end
