# frozen_string_literal: true

class Api::V1::ApiController < ApplicationController
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound do
    render status: 404, json: { error: :not_found, message: 'Registro nao encontrado.' }
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render status: 422, json: { error: :unprocessable_entity, message: error.record.errors }
  end

  rescue_from ActionController::ParameterMissing do
    render status: 422, json: { error: :unprocessable_entity, message: 'Missing params.' }
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      Aluno.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
