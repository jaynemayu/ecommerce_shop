# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'requires a name' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'requires an email' do
      user = User.new(first_name: 'Test', last_name: 'User', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires a unique email' do
      existing_user = User.create(first_name: 'Existing', last_name: 'User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      new_user = User.new(first_name: 'New', last_name: 'User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include('has already been taken')
    end

    it 'requires password confirmation' do
      user = User.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password', password_confirmation: '')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context 'associations' do
    # todo: add associations
  end

  context 'methods' do
    it 'returns the user\'s name' do
      user = User.new(first_name: 'Test', last_name: 'User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user.name).to eq('Test User')
    end
  end
end
