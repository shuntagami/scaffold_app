require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  it '有効なファクトリを持つこと' do
    expect(task).to be_valid
  end

  describe '存在性の検証' do
    it '名称がないと登録できないこと' do
      task.name = ''
      task.valid?
      expect(task.errors[:name]).to include('を入力してください')
    end
    it '締め切りがないと登録できないこと' do
      task.deadline = ''
      task.valid?
      expect(task.errors[:deadline]).to include('を入力してください')
    end
  end

  describe '文字数の検証' do
    it '名称が30文字より多いと登録できないこと' do
      task.name = 'a'*31
      task.valid?
      expect(task.errors[:name]).to include('は30文字以内で入力してください')
    end
    it '名称が30文字であれば登録できること' do
      task.name = 'a'*30
      task.valid?
      expect(task).to be_valid
    end
  end
end
