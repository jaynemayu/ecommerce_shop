class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    # If `name` column exists, split it into `first_name` and `last_name`
    User.reset_column_information
    User.find_each do |user|
      if user.name.present?
        names = user.name.split(' ', 2)
        user.update_columns(first_name: names[0], last_name: names[1])
      end
    end

    remove_column :users, :name
  end

  def down
    add_column :users, :name, :string

    User.reset_column_information
    User.find_each do |user|
      user.update_columns(name: [user.first_name, user.last_name].compact.join(' '))
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
