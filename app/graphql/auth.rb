# frozen_string_literal: true

module Auth
  def current_user
    context[:current_user]
  end
end
