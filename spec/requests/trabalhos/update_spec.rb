# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Aluno edita um trabalho', type: :request do
  let(:trabalho) { create(:trabalho, title: 'errado', url: 'invalido.com') }
  let(:put_params) { { trabalho: { title: 'NAC' } } }
  let(:patch_params) { { trabalho: { title: 'NAC', url: 'github.com/foo/bar' } } }

  context 'success - 200' do
    it 'can use put' do
      put "/api/v1/trabalho/#{trabalho.id}", params: put_params

      expect(response).to have_http_status(:ok)
    end

    it 'can use patch' do
      patch "/api/v1/trabalho/#{trabalho.id}", params: patch_params

      expect(response).to have_http_status(:ok)
    end
  end

  context 'not found - 404' do
    it 'raises error if trabalho dont exist' do
      patch '/api/v1/trabalho/42', params: patch_params

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'unprocessable - 422' do
    it 'raises error if no url is suplied' do
      patch "/api/v1/trabalho/#{trabalho.id}", params: {}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
