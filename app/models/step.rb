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
  include WithPicture

  belongs_to :recipe
  validates :description, presence: true
end
