require 'rails_helper'

describe 'Task' do
  before do
    @task = Task.create(
      title: 'タスク', description: 'これはテスト用のタスクです',
      expire_at: '2019-01-01 00:00:00', priority: 1
    )
  end

  example 'タスクが作成できて、メッセージが表示されること' do
    visit '/tasks/new'
    fill_in 'Title', with: 'タスク1'
    fill_in 'Description', with: 'これはテスト用のタスクです'
    fill_in 'Expire at', with: '2019-01-01 00:00:00'
    fill_in 'Priority', with: '1'
    find(:xpath, '/html[1]/body[1]/form[1]/div[@class="actions"]/input[1]').click
    expect(page).to have_content 'タスクを作成しました'
    expect(Task.exists?(title: 'タスク1')).to eq(true)
  end

  example 'タスクの編集ができて、メッセージが表示されること' do
    visit edit_task_path(@task)

    fill_in 'Title', with: 'タスク-edited'
    find(:xpath, '/html[1]/body[1]/form[1]/div[@class="actions"]/input[1]').click
    expect(page).to have_content '更新しました'
    expect(Task.exists?(title: 'タスク-edited')).to eq(true)
  end

  example 'タスクの削除ができて、メッセージが表示されること' do
    visit '/tasks/'
    expect { click_link '削除' }.to change(Task, :count).by(-1)
    expect(page).to have_content 'タスクを削除しました'
  end
end
