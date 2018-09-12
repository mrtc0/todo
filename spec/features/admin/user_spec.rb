require 'rails_helper'
require 'faker'

describe 'Admin' do
  let!(:admin) { create(:admin) }
  let(:user) { create(:user1) }

  example 'ユーザー一覧ページにアクセスできること' do
    login_as admin
    # page.set_rack_session(user_id: admin_user.id)
    visit admin_users_path
    expect(page).to have_http_status(200)
  end

  example '一般ユーザーはユーザー一覧ページにアクセスできないこと' do
    login_as user
    visit admin_users_path
    expect(page).to have_http_status(404)
  end
end
