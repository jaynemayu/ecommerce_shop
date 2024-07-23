# db/seeds.rb

require 'csv'

csv_file_path = Rails.root.join('db', 'roles.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  level = row['level'].to_i
  name = row['name'].strip

  role = Role.find_or_initialize_by(level: level)

  role.name = name

  if role.new_record? || role.changed?
    role.save!
    puts "Role #{name} with level #{level} has been created/updated."
  end
end

if User.count == 0
  super_admin_role = Role.find_by(level: 99)
  User.create!(
    first_name: 'Super',
    last_name: 'Admin',
    email: 'superadmin@example.com',
    password: 'aA123456789',
    password_confirmation: 'aA123456789',
    role: super_admin_role
  )
end

