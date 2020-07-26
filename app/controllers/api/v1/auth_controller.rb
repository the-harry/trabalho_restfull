# frozen_string_literal: true

class Api::V1::AuthController < Api::V1::ApiController
  skip_before_action :authenticate
  skip_before_action :find_aluno

  def create
    if @aluno.any?
      render status: :created, json: token
    else
      render status: :unauthorized
    end
  end

  private

  def find_aluno
    @credentials = params[:credentials]
    nome, rm = @credentials.split(':')
    @aluno = Aluno.find_by(nome: nome, rm: rm.to_i)
  end

  def token
    @aluno.update(token: Token.encode(@credentials), token_exp: 1.hour.from.now)
  end
end
