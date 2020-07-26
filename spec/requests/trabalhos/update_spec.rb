# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT/PATCH /api/v1/trabalho/:id', type: :request do
  let(:aluno) { create(:aluno) }
  let(:token) { authenticate_with_token("#{aluno.nome}:#{aluno.rm}") }
  let(:trabalho) { create(:trabalho, title: 'bad', url: 'bar.fo', aluno: aluno) }
  let(:put_params) { { trabalho: { title: 'NAC' } } }
  let(:patch_params) { { trabalho: { title: 'NAC', url: 'github.com/foo/bar' } } }

  context 'success - 200' do
    it 'can use put' do
      put "/api/v1/trabalho/#{trabalho.id}", headers: { Authorization: token },
                                             params: put_params

      expect(response).to have_http_status(:ok)
    end

    it 'can use patch' do
      patch "/api/v1/trabalho/#{trabalho.id}", headers: { Authorization: token },
                                               params: patch_params

      expect(response).to have_http_status(:ok)
    end
  end

  context 'YOU SHALL NOT PASS 403' do
    let(:trabalho_do_coleguinha) { create(:trabalho) }

    it 'caso queira meter o loko no trabalho do coleguinha' do
      patch "/api/v1/trabalho/#{trabalho_do_coleguinha.id}", headers: { Authorization: token }

      expect(response).to have_http_status(:forbidden)
      expect(JSON.parse(response.body)['message']).to eq('Nem pense nisso!')
    end
  end

  context 'not found - 404' do
    it 'raises error if trabalho dont exist' do
      patch '/api/v1/trabalho/42', headers: { Authorization: token },
                                   params: patch_params

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'unprocessable - 422' do
    it 'raises error if no url is suplied' do
      patch "/api/v1/trabalho/#{trabalho.id}", headers: { Authorization: token },
                                               params: {}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
