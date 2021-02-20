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
      expect(task).to be_valid
    end
    it '締め切りがないと登録できないこと' do
      task.deadline = ''
      task.valid?
      expect(task).to_not be_valid
    end
  end
end
