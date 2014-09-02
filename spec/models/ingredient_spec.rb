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

require 'rails_helper'

RSpec.describe Ingredient, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
