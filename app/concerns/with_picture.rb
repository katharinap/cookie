module WithPicture
  extend ActiveSupport::Concern

  included do
    mount_uploader :picture, PictureUploader
  end
  
  # returns the basename of the picture file if present or nil
  def picture_file_name
    picture? ? File.basename(picture.to_s) : nil
  end
end
