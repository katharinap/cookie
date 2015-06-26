require 'rails_helper'

describe 'the index view', type: :feature do
  before :all do
    create_list(:recipe, 7)
  end

  it 'displays all the recipes' do
    visit recipes_path
    save_and_open_page
    expect(page).to have_content 'Recipes'
  end
end
