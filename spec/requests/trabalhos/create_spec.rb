# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Aluno cria novo trabalho', type: :request do
  let(:aluno) { Aluno.create(nome: 'foo', rm: 123, sala: Sala.create(nome: 'bar')) }

  context 'success 201' do
    it 'responde com o id do trabalho' do
      post '/api/v1/trabalho', params: { trabalho: { title: 'NAC', url: 'localhost', aluno_id: aluno.id } }

      expect(response).to have_http_status(:created)
      expect(response.body).to eq('{"trabalho_id":1}')
    end
  end

  context 'failure 422' do
    it 'raises error if no title is suplied' do
      post '/api/v1/trabalho', params: { trabalho: { url: 'localhost', aluno_id: aluno.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error if no url is suplied' do
      post '/api/v1/trabalho', params: { trabalho: { title: 'NAC', aluno_id: aluno.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error if no student is suplied' do
      post '/api/v1/trabalho', params: { trabalho: { title: 'NAC', url: 'localhost' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
