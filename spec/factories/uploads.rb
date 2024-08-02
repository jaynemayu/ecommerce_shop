# frozen_string_literal: true

FactoryBot.define do
  factory :upload do
    file { nil }
  end
end

# == Schema Information
#
# Table name: uploads
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
