# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/trabalho', type: :request do
  let(:aluno) { create(:aluno) }
  let(:token) { authenticate_with_token("#{aluno.nome}:#{aluno.rm}") }
  let(:parameters) { { trabalho: { title: 'NAC', url: 'localhost' } } }

  context 'successo - 201' do
    before do
      DatabaseCleaner.clean

      post '/api/v1/trabalho', headers: { Authorization: token },
                               params: parameters
    end

    it 'responde com 201' do
      expect(response).to have_http_status(:created)
    end

    it 'responde com o id do trabalho' do
      expect(response.body).to eq('{"trabalho_id":1}')
    end

    it 'associa current_user com o trabalho' do
      expect(Trabalho.last.aluno_id).to eq(aluno.id)
    end
  end

  context 'trabalho nao processavel - 422' do
    it 'raises error if no title is suplied' do
      post '/api/v1/trabalho', headers: { Authorization: token },
                               params: { trabalho: { url: 'localhost' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'reclama se nao mandar a url' do
      post '/api/v1/trabalho', headers: { Authorization: token },
                               params: { trabalho: { title: 'NAC' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
