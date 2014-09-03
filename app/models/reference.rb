# == Schema Information
#
# Table name: references
#
#  id         :integer          not null, primary key
#  url        :string
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reference < ActiveRecord::Base
  belongs_to :recipe
end
