require 'rails_helper'

feature 'the signin process' do
  before :all do
    @user = create(:user)
  end

  it "signs me in" do
    skip '... sass/sprockets issue ...'
    visit new_user_session_path
    # save_and_open_page
    fill_in 'Name', :with => @user.name
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
    expect(page).to have_content 'successfully'
    expect(current_path).to eq('/')
  end

  it "does not sign me in if the password is incorrect" do
    skip '... sass/sprockets issue ...'
    visit new_user_session_path
    fill_in 'Name', :with => @user.name
    fill_in 'Password', :with => 'invalid_password'
    click_button 'Sign in'
    expect(page).to have_content 'Invalid name or password.'
    expect(current_path).to eq(new_user_session_path)
  end
end
