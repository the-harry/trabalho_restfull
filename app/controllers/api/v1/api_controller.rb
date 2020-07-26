# frozen_string_literal: true

class Api::V1::ApiController < ApplicationController
  rescue_from StandardError do |erro|
    if erro.is_a?(ActiveRecord::RecordNotFound)
      response[:status] = 404
      response[:body] = { error: :not_found, message: 'Registro nao encontrado.' }
    end

    if erro.is_a?(ActiveRecord::RecordInvalid)
      response[:status] = 422
      response[:body] = { error: :unprocessable_entity, message: erro.record.errors }
    end

    if erro.is_a?(ActionController::ParameterMissing)
      response[:status] = 422
      response[:body] = { error: :unprocessable_entity, message: 'Missing params.' }
    end

    response[:status] ||= 500
    response[:body] ||= { error: :internal_server_error, message: erro.to_s }

    render status: response[:status], json: response[:body]
  end
end
