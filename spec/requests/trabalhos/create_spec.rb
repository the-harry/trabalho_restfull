# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/trabalho', type: :request do
  let(:aluno) { create(:aluno) }
  let(:parameters) { { trabalho: { title: 'NAC', url: 'localhost', aluno_id: aluno.id } } }

  context 'successo - 201' do
    before do
      post '/api/v1/trabalho', params: parameters
    end

    it 'responde com 201' do
      expect(response).to have_http_status(:created)
    end

    it 'responde com o id do trabalho' do
      expect(response.body).to eq('{"trabalho_id":1}')
    end
  end

  context 'trabalho nao processavel - 422' do
    it 'raises error if no title is suplied' do
      post '/api/v1/trabalho', params: { trabalho: { url: 'localhost', aluno_id: aluno.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'reclama se nao mandar a url' do
      post '/api/v1/trabalho', params: { trabalho: { title: 'NAC', aluno_id: aluno.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'reclama se nao tiver aluno_id' do
      post '/api/v1/trabalho', params: { trabalho: { title: 'NAC', url: 'localhost' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
