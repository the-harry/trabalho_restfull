# frozen_string_literal: true

class Api::V1::TrabalhosController < Api::V1::ApiController
  before_action :find_trabalho, only: %i[show update destroy]

  def index
    trabalhos = Trabalho.all

    if trabalhos.exists?
      render status: :ok, json: trabalhos
    else
      render status: :no_content
    end
  end

  def create
    trabalho = Trabalho.create!(sanitized_trabalho(params))

    render status: :created, json: { trabalho_id: trabalho.id }
  end

  def show
    render status: :ok, json: @trabalho
  end

  def update
    render status: :ok if @trabalho.update!(sanitized_trabalho(params))
  end

  def destroy
    render status: :ok if @trabalho.destroy!
  end

  private

  def sanitized_trabalho(params)
    params.require(:trabalho).permit(:title, :url, :aluno_id)
  end

  def find_trabalho
    @trabalho = Trabalho.find(params['id'])
  end
end
