# frozen_string_literal: true

class ShopUser < ApplicationRecord
  belongs_to :user
  belongs_to :shop
end

# == Schema Information
#
# Table name: shop_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  shop_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shop_users_on_shop_id  (shop_id)
#  index_shop_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#  fk_rails_...  (user_id => users.id)
#
