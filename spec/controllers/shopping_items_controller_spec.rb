require 'rails_helper'

RSpec.shared_examples 'a shopping item action' do |action, method: :get, params: {}, create_item: false, skip_items_test: false|

  context 'when user is signed in' do
    before do
      @user = create(:user)
      sign_in @user
      @items = create_list(:shopping_item, 3, user: @user)
    end

    after do
      sign_out @user
    end

    describe "#{method.to_s.upcase} #{action}" do
      it "assigns the user's items as @items" do
        create(:shopping_item, user: build_stubbed(:user))
        if create_item
          item = create(:shopping_item)
          send(method, action, id: item.id, shopping_item: params)
          expect(assigns(:item)).to eq(item)
        else
          send(method, action)
        end
        expect(assigns(:items)).to eq(@items) unless skip_items_test
      end
    end
  end

  context 'when user is not signed in' do
    describe "#{method.to_s.upcase} #{action}" do
      it 'redirects to the sign up page' do
        if create_item
          send(method, action, id: create(:shopping_item).id)
        else
          send(method, action)
        end
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

RSpec.describe ShoppingItemsController, :type => :controller do
  describe 'index' do
    it_behaves_like "a shopping item action", :index
  end

  %i(show edit toggle_active destroy delete).each do |action|
    describe "#{action}" do
      params = action == :create ? { name: 'new item' } : {}
      skip_items_test = %i(show edit delete).include?(action)
      method = action == :create ? :post : :get
      it_behaves_like "a shopping item action", action, method: method, create_item: true, skip_items_test: skip_items_test, params: params
    end
  end
end
