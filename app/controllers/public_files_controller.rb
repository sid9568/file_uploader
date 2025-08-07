class PublicFilesController < ApplicationController
  def show
    file = FileUpload.find_by(share_token: params[:token])

    if file&.file&.attached?
      redirect_to url_for(file.file)
    else
      render plain: "File not found", status: :not_found
    end
  end
end
