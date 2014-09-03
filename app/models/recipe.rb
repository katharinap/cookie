# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  directions :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recipe < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  # returns an array of directions paragraphs (split by newlines)
  def steps
    the_steps = directions.split("\n")
    the_steps.delete_if { |s| s.blank? }
    the_steps
  end
end
