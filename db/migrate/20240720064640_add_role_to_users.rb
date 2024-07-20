class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def up
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

    add_reference :users, :role, foreign_key: true

    super_admin_role = Role.find_by(level: 99)
    raise 'super_admin role not found' unless super_admin_role

    User.update_all(role_id: super_admin_role.id)

    change_column_null :users, :role_id, false
  end

  def down
    remove_reference :users, :role, foreign_key: true
  end
end
