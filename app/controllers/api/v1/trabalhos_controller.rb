class Api::V1::TrabalhosController < Api::V1::ApiController
  def index
    trabalhos = Trabalho.all

    if trabalhos.exists?
      render status: :ok, json: trabalhos
    else
      render status: :no_content
    end
  end

  def create
    trabalho = Trabalho.new(sanitized_trabalho(params))

    if trabalho.save
      render status: :created, json: { trabalho_id: trabalho.id }
    else
      render status: :unprocessable_entity, json: { erros: trabalho.errors }
    end
  end

  def show
    trabalho = Trabalho.find_by(id: params['id'])

    if trabalho.present?
      render status: :ok, json: trabalho
    else
      render status: :not_found
    end
  end

  def update; end

  def destroy; end

  private

  def sanitized_trabalho(params)
    params.require(:trabalho).permit(:title, :url, :aluno_id)
  end
end
