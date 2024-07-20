# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:role) do
    super_admin_role = Role.find_or_initialize_by(level: 99)
    super_admin_role.update(name: 'super_admin')

    super_admin_role
  end

  context 'validations' do
    it 'requires a name' do
      user = described_class.new(email: 'test@example.com', password: 'password', password_confirmation: 'password',
                                 role:)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'requires an email' do
      user = described_class.new(first_name: 'Test', last_name: 'User', password: 'password',
                                 password_confirmation: 'password', role:)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires a unique email' do
      described_class.create(first_name: 'Existing', last_name: 'User', email: 'test@example.com',
                             password: 'password', password_confirmation: 'password', role:)
      new_user = described_class.new(first_name: 'New', last_name: 'User', email: 'test@example.com',
                                     password: 'password', password_confirmation: 'password', role:)
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include('has already been taken')
    end

    it 'requires password confirmation' do
      user = described_class.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                                 password_confirmation: '', role:)
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires a role_id' do
      user = described_class.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                                 password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include('must exist')
    end

    it 'is valid with a valid role' do
      user = described_class.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                                 password_confirmation: 'password', role:)
      expect(user).to be_valid
    end
  end

  context 'methods' do
    it 'returns the user\'s name' do
      user = described_class.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password',
                                 password_confirmation: 'password')
      expect(user.name).to eq('Test User')
    end
  end
end
