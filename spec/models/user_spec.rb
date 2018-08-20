require 'rails_helper'

describe User, type: :model do
  context 'Userを作成するとき' do
    it '正常に作成できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'パスワードが短い場合は作成できないこと' do
      user = build(:short_password)
      user.valid?
      expect(user.errors.size).to eq(1)
    end

    it 'パスワードに数字が含まれていない場合は作成できないこと' do
      user = build(:no_number_password)
      user.valid?
      expect(user.errors.size).to eq(1)
    end

    it 'パスワードに大文字が含まれていない場合は作成できないこと' do
      user = build(:no_uppercase_in_password)
      user.valid?
      expect(user.errors.size).to eq(1)
    end

    it 'パスワードに小文字が含まれていない場合は作成できないこと' do
      user = build(:no_lowercase_in_password)
      user.valid?
      expect(user.errors.size).to eq(1)
    end

    it 'パスワードに文字が含まれていない場合は作成できないこと' do
      user = build(:no_letter_in_password)
      user.valid?
      expect(user.errors.size).to eq(1)
    end
  end
end
