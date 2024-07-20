# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build(:role) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a level' do
      subject.level = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:level]).to include("can't be blank")
    end

    it 'is not valid with a duplicate name' do
      create(:role, name: subject.name)
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("has already been taken")
    end

    it 'is valid with a unique name' do
      create(:role, name: "admin")
      expect(subject).to be_valid
    end

    it 'is not valid with a level less than 1' do
      subject.level = 0
      expect(subject).to_not be_valid
      expect(subject.errors[:level]).to include("must be greater than or equal to 1")
    end

    it 'is valid with a level greater than or equal to 1' do
      subject.level = 1
      expect(subject).to be_valid
    end
  end
end
