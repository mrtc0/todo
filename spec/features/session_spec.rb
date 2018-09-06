require 'rails_helper'

describe 'Session' do
  let(:user1) { create(:user1) }

  example 'ログインできること' do
    visit login_path
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: 'Password1234'
    find_by_id('login').click

    expect(page).to have_content I18n.t('view.session.message.login_successful')
  end

  example 'ログアウトできること' do
    visit login_path
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: 'Password1234'
    find_by_id('login').click

    find_by_id('logout-link').click
    visit tasks_path
    expect(current_path).to eq(login_path)
  end
end
