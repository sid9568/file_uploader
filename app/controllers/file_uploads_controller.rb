class FileUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_upload, only: %i[ show edit update destroy share ]

  def index
    @file_uploads = current_user.file_uploads
  end

  def show
  end

  def new
    @file_upload = current_user.file_uploads.new
  end

  def edit
  end

  def create
    @file_upload = current_user.file_uploads.new(file_upload_params)
    @file_upload.file.attach(params[:file_upload][:file_type])

    if @file_upload.save
      redirect_to root_path, notice: "File uploaded successfully."
    else
      render :new
    end
  end

  def update
    if @file_upload.update(file_upload_params)
      redirect_to @file_upload, notice: "File updated."
    else
      render :edit
    end
  end

  def destroy
    @file_upload.destroy
    redirect_to file_uploads_url, notice: "File deleted."
  end

   def share
    if @file_upload.user == current_user
      redirect_to public_file_path(@file_upload.share_token)
    else
      redirect_to file_uploads_path, alert: "Unauthorized access"
    end
  end

  private

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:id])
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file_type)
  end
end
