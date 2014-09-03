# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  name       :string
#  amount     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  notes      :string
#

class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :name, presence: true
  before_save :strip_whitespace

  # returns true if notes contains any characters
  def has_notes?
    notes && !notes.blank?
  end

  private

  # removes leading and trailing whitespace from name, amount and
  # notes
  def strip_whitespace
    %i(name amount notes).each do |attr|
      value = self.send(attr)
      self.send("#{attr}=", value.strip) if value
    end
  end
end
