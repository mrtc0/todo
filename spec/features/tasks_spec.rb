require 'rails_helper'
require 'kaminari'
require 'faker'

ITEM_PER_PAGE = Kaminari.config.default_per_page # kaminari の1ページあたりのアイテム数

describe 'Task' do
  let(:user1) { create(:user1) }

  let(:task) { Task.find_by(user: user1) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
  end

  example 'タスクが作成できて、メッセージが表示されること' do
    visit new_task_path
    fill_in 'Title', with: 'タスク1'
    fill_in 'Description', with: 'これはテスト用のタスクです'
    fill_in 'expire_at', with: Faker::Time.forward.to_datetime
    select 'meddium', from: 'Priority'
    find_by_id('submit').click
    expect(page).to have_content I18n.t('view.task.message.created')
    expect(Task.exists?(title: 'タスク1')).to be_truthy
  end

  example 'タスクの編集ができて、メッセージが表示されること' do
    visit edit_task_path(task)

    fill_in 'Title', with: 'タスク-edited'
    find_by_id('submit').click
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

  example '期限がnilのタスクが作成できて、正しく表示されること' do
    visit new_task_path
    fill_in 'Title', with: 'non-expire-task'
    fill_in 'Description', with: 'これは期限が設定されていないタスクです'
    fill_in 'expire_at', with: Faker::Time.forward.to_datetime
    select 'meddium', from: 'Priority'
    find_by_id('submit').click

    expect(page).to have_content I18n.t('view.task.message.created')
    expect(Task.exists?(title: 'non-expire-task')).to be_truthy
    visit tasks_path
    expect(page).to have_http_status(200)
  end

  example '期限が近い順でソートされること' do
    visit tasks_path
    click_link('sort_by_expire')
    @expire_at_days = page.all('#expire_at').map(&:text)
    @expect_days = Task.where(user: user1).order(expire_at: 'ASC').map { |t| t.expire_at&.strftime('%Y/%m/%d %H:%M') }
    expect(@expire_at_days).to eq(@expect_days)
  end

  example 'タイトルで検索できること' do
    visit '/'
    fill_in 'title', with: 'タスク'
    find_by_id('search').click
    # %E3%82%BF%E3%82%B9%E3%82%AF = タスク
    visit '/tasks?title=%E3%82%BF%E3%82%B9%E3%82%AF&status='
    expect(page.all('tbody tr').count).to eq(Task.filter_by_title('タスク').where(user: user1).count)
  end

  example 'ステータスで検索できること' do
    visit '/'
    select 'doing', from: 'status'
    find_by_id('search').click
    visit '/tasks?title=&status=1'
    expect(page.all('tbody tr').count).to eq(Task.doing.count)
  end

  example 'タイトルとステータスで検索できること' do
    visit '/'
    fill_in 'title', with: 'task'
    select 'doing', from: 'status'
    find_by_id('search').click
    # タイトルが「task」を含み、かつ、doingであるものを検索
    visit '/tasks?title=task&status=1'
    expect_task = Task.filter_by_title('task').filter_by_status('doing')
    expect(page.all('tbody tr').count).to eq(expect_task.count)
  end

  example '優先度が高い順でソートされること' do
    create_list(:priority_is_random_task, 10, user: user1)
    visit tasks_path
    click_link('sort_by_priority_desc')
    @priorities = page.all('#priority').map(&:text)
    @expect_priorities = Task.order(priority: 'DESC').limit(ITEM_PER_PAGE).map(&:priority)
    expect(@priorities).to eq(@expect_priorities)
  end

  example '優先度が低い順でソートされること' do
    create_list(:priority_is_random_task, 10, user: user1)
    visit tasks_path
    click_link('sort_by_priority_asc')
    @priorities = page.all('#priority').map(&:text)
    @expect_priorities = Task.order(priority: 'ASC').limit(ITEM_PER_PAGE).map(&:priority)
    expect(@priorities).to eq(@expect_priorities)
  end

  example 'ページネーションによってタスクが10個ずつ表示されていること' do
    create_list(:user1_task, 50, user: user1)
    visit tasks_path
    expect(page.all('#task_table_body tr').size).to eq(ITEM_PER_PAGE)
    click_link('2')
    expect(page.all('#task_table_body tr').size).to eq(ITEM_PER_PAGE)
  end
end
