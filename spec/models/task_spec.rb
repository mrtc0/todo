require 'rails_helper'

describe Task, type: :model do
  let(:user1) { create(:user1) }

  context 'Taskを作成するとき' do
    it '正常に作成できること' do
      task = build(:task, user: user1)
      expect(task).to be_valid
    end

    it 'titleが入っていないと作成できないこと' do
      task = build(:nontitle_task, user: user1)
      task.valid?
      expect(task.errors[:title].size).to eq(1)
    end

    it '期日が作成日時より過去の場合は作成できないこと' do
      task = build(:expire_of_past_task, user: user1)
      task.valid?
      expect(task.errors.size).to eq(1)
    end

    it 'ステータスがデフォルトで未着手であること' do
      task = build(:user1_task)
      expect(task.status).to eq('todo')
    end

    it 'ステータスを変更できること' do
      task = build(:task, user: user1)
      # 着手中に変更する
      task.doing!
      expect(task).to be_valid
      task.save
      expect(task.status).to eq('doing')

      # 完了に変更する
      task.done!
      expect(task).to be_valid
      task.save
      expect(task.status).to eq('done')
    end
  end

  it 'タイトルであいまい検索ができること' do
    task = create(:task, user: user1, title: "exist-task")
    # exist-task が見つかること
    params = { title: 'exist-task' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)

    # タスクが見つからないこと
    params = { title: 'non-exist-task' }
    expect(Task.filter_by_title_and_status(params).count).to eq(0)
  end

  it 'ステータスで検索ができること' do
    params = { status: 'todo' }
    expect(Task.filter_by_title_and_status(params).count).to eq(Task.where(status: 'todo').count)

    params = { status: 'doing' }
    expect(Task.filter_by_title_and_status(params).count).to eq(Task.where(status: 'doing').count)

    params = { status: 'done' }
    expect(Task.filter_by_title_and_status(params).count).to eq(Task.where(status: 'done').count)
  end

  it 'タイトルとステータスで検索ができること' do
    task = create(:task, user: user1, title: 'todo-task')
    # todo-task という名前の todo 状態のタスクが見つかること
    params = { title: 'todo-task', status: 'todo' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)

    # todo-task という名前の doing 状態のタスクが見つからないこと
    params = { title: 'todo-task', status: 'doing' }
    expect(Task.filter_by_title_and_status(params).count).to eq(0)
  end

  it '優先度が高い順で並び替えれること' do
    params = { priority: 'desc' }
    desc_priorities = Task.all.map { |task| task.priority }
    expect(Task.sort_by_priority(params).map { |task| task.priority }).to eq(desc_priorities)
  end

  it '優先度が低い順で並び替えれること' do
    params = { priority: 'asc' }
    desc_priorities = Task.all.map { |task| task.priority }
    expect(Task.sort_by_priority(params).map { |task| task.priority }).to eq(desc_priorities.reverse)
  end
end
