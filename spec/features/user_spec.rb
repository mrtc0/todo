require 'rails_helper'
require 'faker'

describe 'User' do
  example 'ユーザーの登録ができること' do
    visit signup_path
    fill_in 'Email', with: 'test-user@example.com'
    fill_in 'Password', with: 'Password1234'
    fill_in 'Password confirm', with: 'Password1234'
    find_by_id('registration').click
    expect(User.exists?(email: 'test-user@example.com')).to eq(true)
    expect(page).to have_content I18n.t('view.user.message.registration_successful')
  end

  example '既に登録されているメールアドレスでは登録できないこと' do
    create(:user1)
    visit signup_path
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'Password1234'
    fill_in 'Password confirm', with: 'Password1234'
    find_by_id('registration').click
    expect(page).to have_content I18n.t('errors.messages.taken')
	end

  example '確認用パスワードが異なる場合は登録できないこと' do
    visit signup_path
    fill_in 'Email', with: 'incorrect-user@example.com'
    fill_in 'Password', with: 'Password1234'
    fill_in 'Password confirm', with: 'Password1235'
    find_by_id('registration').click
    expect(page).to have_content I18n.t('view.user.message.missmatch_password')
  end
end
