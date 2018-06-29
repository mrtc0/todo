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
  end
end
