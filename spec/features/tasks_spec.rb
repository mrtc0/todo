require 'rails_helper'

describe 'Task' do
  before do
    @task = create_list(:task, 3)
  end

  example 'タスクが作成できて、メッセージが表示されること' do
    visit new_task_path
    fill_in 'Title', with: 'タスク1'
    fill_in 'Description', with: 'これはテスト用のタスクです'
    fill_in 'Expire at', with: '2019-01-01 00:00:00'
    fill_in 'Priority', with: '1'
    find(:xpath, '/html[1]/body[1]/form[1]/div[@class="actions"]/input[1]').click
    expect(page).to have_content I18n.t('view.task.message.created')
    expect(Task.exists?(title: 'タスク1')).to be_truthy
  end

  example 'タスクの編集ができて、メッセージが表示されること' do
    visit edit_task_path(@task)

    fill_in 'Title', with: 'タスク-edited'
    find(:xpath, '/html[1]/body[1]/form[1]/div[@class="actions"]/input[1]').click
    expect(page).to have_content I18n.t('view.task.message.updated')
    expect(Task.exists?(title: 'タスク-edited')).to eq(true)
  end

  example 'タスクの削除ができて、メッセージが表示されること' do
    visit tasks_path
    expect { click_link '削除', match: :first }.to change(Task, :count).by(-1)
    expect(page).to have_content I18n.t('view.task.message.deleted')
  end

  example 'タスクが降順で表示されること' do
    visit tasks_path
    @created_at_days = page.all('#created_at').map(&:text)
    expect(@created_at_days).to eq(@created_at_days.sort.reverse)
  end
end
