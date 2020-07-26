# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/trabalho/:id', type: :request do
  let(:aluno) { create(:aluno) }
  let(:token) { authenticate_with_token("#{aluno.nome}:#{aluno.rm}") }

  context 'success 200' do
    let(:trabalho) { create(:trabalho, aluno: aluno) }

    before do
      get "/api/v1/trabalho/#{trabalho.id}", headers: { Authorization: token }
    end

    it 'responde 200 ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'responde com o id do trabalho' do
      expect(JSON.parse(response.body)['id']).to eq(trabalho.id)
    end

    it 'responde com o titulo do trabalho' do
      expect(JSON.parse(response.body)['title']).to eq(trabalho.title)
    end

    it 'responde com a url do trabalho' do
      expect(JSON.parse(response.body)['url']).to eq(trabalho.url)
    end

    it 'responde com o id do aluno' do
      expect(JSON.parse(response.body)['aluno_id']).to eq(trabalho.aluno.id)
    end
  end

  context 'YOU SHALL NOT PASS 403' do
    let(:trabalho_do_coleguinha) { create(:trabalho) }

    it 'caso queira ver o trabalho do coleguinha' do
      get "/api/v1/trabalho/#{trabalho_do_coleguinha.id}", headers: { Authorization: token }

      expect(response).to have_http_status(:forbidden)
      expect(JSON.parse(response.body)['message']).to eq('Nem pense nisso!')
    end
  end

  context 'trabalho nao encontrado 404' do
    it 'caso nao exista' do
      get '/api/v1/trabalho/42', headers: { Authorization: token }

      expect(response).to have_http_status(:not_found)
    end
  end
end
