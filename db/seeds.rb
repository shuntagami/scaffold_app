require 'faker'
require 'date'

User.create!(name: '管理者',
             email: 'admin@example.com',
             password: 'password',
             password_confirmation: 'password',
             created_at: Time.zone.now,
             updated_at: Time.zone.now,
             admin: true,
            )

10.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    created_at: Time.zone.now,
    updated_at: Time.zone.now,
    admin: false,
  )
end

admin_user = User.find(1)

admin_user.tasks.create!(
  name: 'test',
  deadline: Date.today,
)
