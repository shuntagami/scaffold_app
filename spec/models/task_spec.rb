require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  it '有効なファクトリを持つこと' do
    expect(task).to be_valid
  end
end
