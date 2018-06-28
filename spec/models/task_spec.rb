require 'rails_helper'

describe Task, type: :model do
  context 'Taskを作成するとき' do
    it '正常に作成できること' do
      task = Task.new(
        title: 'タスク1',
        description: '正常系タスク1',
        priority: 1,
        expire_at: '2019-12-24 00:00:00'
      )
      expect(task).to be_valid
    end

    it 'titleが入っていないと作成できないこと' do
      task = Task.new
      task.valid?
      expect(task.errors[:title].size).to eq(1)
    end

    it '期日が作成日時より過去の場合は作成できないこと' do
      task = Task.new(
        title: 'タスク2',
        description: '異常系タスク2',
        priority: 1,
        expire_at: '1995-12-24 00:00:00'
      )
      task.valid?
      expect(task.errors.size).to eq(1)
    end

    it '優先度が数字じゃない場合は作成できないこと' do
      task = Task.new(
        title: 'タスク2',
        description: '異常系タスク2',
        priority: 'wei',
        expire_at: '2020-12-24 00:00:00'
      )
      task.valid?
      expect(task.errors[:priority].size).to eq(1)
    end
  end
end
