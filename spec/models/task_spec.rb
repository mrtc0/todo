require 'rails_helper'

describe Task, type: :model do
  context 'Taskを作成するとき' do
    it '正常に作成できること' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'titleが入っていないと作成できないこと' do
      task = build(:nontitle_task)
      task.valid?
      expect(task.errors[:title].size).to eq(1)
    end

    it '期日が作成日時より過去の場合は作成できないこと' do
      task = build(:expire_of_past_task)
      task.valid?
      expect(task.errors.size).to eq(1)
    end

    it '優先度が数字じゃない場合は作成できないこと' do
      task = build(:priority_is_not_integer_task)
      task.valid?
      expect(task.errors[:priority].size).to eq(1)
    end

    it '優先度がnilのときは作成できること' do
      task = build(:priority_is_nil_task)
      expect(task).to be_valid
    end

    it 'ステータスがデフォルトで未着手であること' do
      task = build(:task)
      expect(task.status).to eq('todo')
    end

    it 'ステータスを変更できること' do
      task = build(:task)
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
    task = create(:task)
    # タスク1が見つかること
    params = { title: '1' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)

    # タスクが見つからないこと
    params = { title: 'non-exist-task' }
    expect(Task.filter_by_title_and_status(params).count).to eq(0)
  end

  it 'ステータスで検索ができること' do
    task = create(:task)
    # タスク1が見つかること
    params = { status: 'todo' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)

    # タスクが見つからないこと
    task.doing!
    task.save
    params = { status: 'todo' }
    expect(Task.filter_by_title_and_status(params).count).to eq(0)

    # タスク1が見つかること
    params = { status: 'doing' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)
  end

  it 'タイトルとステータスで検索ができること' do
    task = create(:task)
    # タスク1が見つかること
    params = { title: '1', status: 'todo' }
    expect(Task.filter_by_title_and_status(params).count).to eq(1)

    # タスクが見つからないこと
    params = { title: '1', status: 'doing' }
    expect(Task.filter_by_title_and_status(params).count).to eq(0)
  end
end
