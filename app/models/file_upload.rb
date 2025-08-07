class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  before_create :set_file_type, :generate_share_token
  validate :file_size_validation

  private

  def set_file_type
    self.file_type = file.blob.content_type if file.attached?
  end

  def generate_share_token
    self.share_token = SecureRandom.hex(10)
  end

  def file_size_validation
    return unless file.attached?

    if file.blob.byte_size > 1.gigabyte
      errors.add(:file, "size cannot be greater than 1 GB")
      file.purge
    end
  end
end
