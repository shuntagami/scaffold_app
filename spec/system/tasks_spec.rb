require 'rails_helper'
require 'date'

describe "タスク管理機能", type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { create(:task, name: 'ユーザーAの一週間後のタスク', deadline: Date.today+7, user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content 'ユーザーAの一週間後のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'ユーザーAのタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      fill_in '期限', with: dead_line
      click_button '登録する'
    end

    context '新規作成画面で名称と期限を入力したとき' do
      let(:task_name) { '新規作成のテストを書く' }
      let(:dead_line) { Date.today }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { '' }
      let(:dead_line) { Date.today }

      it 'エラーになる' do
        expect(page).to have_content '名称を入力してください'
      end
    end

    context '新規作成画面で期限を入力しなかっとき' do
      let(:task_name) { '新規作成のテストを書く' }
      let(:dead_line) { }

      it 'エラーになる' do
        expect(page).to have_content '期限を入力してください'
      end
    end
  end

  describe 'ソート機能（期限が近い順）' do
    let(:login_user) { user_a }

    before do
      # 最初の登録
      visit new_task_path
      fill_in '名称', with: task_name1
      fill_in '期限', with: dead_line1
      click_button '登録する'
      # 2回目の登録
      visit new_task_path
      fill_in '名称', with: task_name2
      fill_in '期限', with: dead_line2
      click_button '登録する'
      click_link '直近のタスク'
    end

    context '今日のタスク、明日のタスクの順で登録したとき' do
      let(:task_name1) { '今日のタスク' }
      let(:dead_line1) { Date.today }
      let(:task_name2) { '明日のタスク' }
      let(:dead_line2) { Date.tomorrow }
      it '期限が近い順に並んでいる' do
        expect(all('tbody tr')[0]).to have_content '今日のタスク'
        expect(all('tbody tr')[1]).to have_content '明日のタスク'
      end
    end

    context '明日のタスク、今日のタスクの順で登録したとき' do
      let(:task_name1) { '明日のタスク' }
      let(:dead_line1) { Date.tomorrow }
      let(:task_name2) { '今日のタスク' }
      let(:dead_line2) { Date.today }
      it '期限が近い順に並んでいる' do
        expect(all('tbody tr')[0]).to have_content '今日のタスク'
        expect(all('tbody tr')[1]).to have_content '明日のタスク'
      end
    end
  end
end
