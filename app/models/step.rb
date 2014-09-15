# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  recipe_id   :integer
#  idx         :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  picture     :string
#

class Step < ActiveRecord::Base
  belongs_to :recipe
  mount_uploader :picture, PictureUploader
  validates :description, presence: true

  # returns the basename of the picture file if present or nil
  def picture_file_name
    picture? ? File.basename(picture.to_s) : nil
  end
end
