require 'date'

FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'Rspec&Capybara&FactoryBotを準備する' }
    deadline { Date.today }
    association :user
  end
end
