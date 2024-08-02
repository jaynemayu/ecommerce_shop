# frozen_string_literal: true

class Upload < ApplicationRecord
  has_one_attached :file
end

# == Schema Information
#
# Table name: uploads
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
