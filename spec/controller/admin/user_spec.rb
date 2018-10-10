require 'rails_helper'

describe Admin::UsersController, :type => :controller do
  describe 'GET admin/users#index' do
    let(:admin) { create(:admin) }

    before do
      login admin
      get :index
    end

    it '200が返ること' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT admin/users#update' do
    let(:admin) { create(:admin) }
    let(:user) { create(:user1) }
    let(:update_params) do
      { email: 'weitarou@example.com' }
    end
    let(:invalid_params) do
      { email: 'weitarou' }
    end

    before do
      login admin
    end

    it 'アップデートできること' do
      put :update, params: { id: user.id, user: update_params }
      expect(User.where(email: 'weitarou@example.com').count).to eq(1)
    end

    it 'メールアドレスが不正な場合アップデートできないこと' do
      put :update, params: { id: user.id, user: invalid_params }
      expect(User.where(email: 'weitarou').count).to eq(0)
    end
  end
end
