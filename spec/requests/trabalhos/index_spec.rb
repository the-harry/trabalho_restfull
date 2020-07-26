# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/trabalhos', type: :request do
  context 'successo - 200' do
    let!(:trabalho) { create(:trabalho) }
    let!(:outro_trabalho) { create(:trabalho) }

    before do
      get '/api/v1/trabalhos'
    end

    it 'responder com codigo 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'retorna todos trabalhos persistidos' do
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'responde com o id do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'id')).to eq(trabalho.id)
    end

    it 'responde com o titulo do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'title')).to eq(trabalho.title)
    end

    it 'responde com a url do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'url')).to eq(trabalho.url)
    end

    it 'responde com o id do aluno' do
      expect(JSON.parse(response.body).dig(0, 'aluno_id')).to eq(trabalho.aluno.id)
    end
  end

  context 'nenhum trabalho cadastrado - 204' do
    it 'caso nao tenha nenhum trabalho' do
      get '/api/v1/trabalhos'

      expect(response).to have_http_status(:no_content)
    end
  end
end
