# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:execute]
  skip_before_action :authenticate_user!, only: [:execute]
  before_action :authenticate_user_for_graphql!

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }

    result = EcommerceShopSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")
    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def authenticate_user_for_graphql!

    return unauthorized unless current_user
  end

  def unauthorized
    render json: { errors: ['You need to sign in or sign up before continuing.'] }, status: :unauthorized
  end
end