# db/seeds.rb

# User.where(email: 'superadmin@example.com').destroy_all

User.create!(
  name: 'Super Admin',
  email: 'superadmin@example.com',
  password: 'aA123456789',
  password_confirmation: 'aA123456789'
)