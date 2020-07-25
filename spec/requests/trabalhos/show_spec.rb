# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Aluno pode ver um trabalho enviado', type: :request do
  context 'success 200' do
    let(:trabalho) { create(:trabalho) }

    before do
      get "/api/v1/trabalho/#{trabalho.id}"
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

  context 'trabalho nao encontrado 404' do
    it 'caso nao exista' do
      get '/api/v1/trabalho/42'

      expect(response).to have_http_status(:not_found)
    end
  end
end
