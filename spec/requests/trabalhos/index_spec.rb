# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/trabalhos', type: :request do
  let(:aluno) { create(:aluno) }
  let(:token) { authenticate_with_token("#{aluno.nome}:#{aluno.rm}") }

  context 'successo - 200' do
    let!(:trabalhos) { create_list(:trabalho, 2, aluno: aluno) }

    before do
      get '/api/v1/trabalhos', headers: { Authorization: token }
    end

    it 'responder com codigo 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'retorna todos trabalhos persistidos' do
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'responde com o id do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'id')).to eq(trabalhos[0].id)
      expect(JSON.parse(response.body).dig(1, 'id')).to eq(trabalhos[1].id)
    end

    it 'responde com o titulo do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'title')).to eq(trabalhos[0].title)
      expect(JSON.parse(response.body).dig(1, 'title')).to eq(trabalhos[1].title)
    end

    it 'responde com a url do trabalho' do
      expect(JSON.parse(response.body).dig(0, 'url')).to eq(trabalhos[0].url)
      expect(JSON.parse(response.body).dig(1, 'url')).to eq(trabalhos[1].url)
    end

    it 'responde com o id do aluno' do
      expect(JSON.parse(response.body).dig(0, 'aluno_id')).to eq(trabalhos[0].aluno.id)
      expect(JSON.parse(response.body).dig(1, 'aluno_id')).to eq(trabalhos[1].aluno.id)
    end
  end

  context 'nenhum trabalho cadastrado - 204' do
    it 'caso nao tenha nenhum trabalho' do
      get '/api/v1/trabalhos', headers: { Authorization: token }

      expect(response).to have_http_status(:no_content)
    end
  end
end
