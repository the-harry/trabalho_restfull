# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /api/v1/trabalho/:id', type: :request do
  let(:aluno) { create(:aluno) }
  let(:token) { authenticate_with_token("#{aluno.nome}:#{aluno.rm}") }
  let(:trabalho) { create(:trabalho, title: 'errado', url: 'invalido.com', aluno: aluno) }

  context 'successo - 200' do
    it 'apaga o trabalho' do
      delete "/api/v1/trabalho/#{trabalho.id}", headers: { Authorization: token }

      expect(response).to have_http_status(:ok)
    end
  end

  context 'YOU SHALL NOT PASS 403' do
    let(:trabalho_do_coleguinha) { create(:trabalho) }

    it 'caso queira meter o loko no trabalho do coleguinha' do
      delete "/api/v1/trabalho/#{trabalho_do_coleguinha.id}", headers: { Authorization: token }

      expect(response).to have_http_status(:forbidden)
      expect(JSON.parse(response.body)['message']).to eq('Nem pense nisso!')
    end
  end

  context 'nao encontrado - 404' do
    it 'responde com erro quando nao existe' do
      delete '/api/v1/trabalho/42', headers: { Authorization: token }

      expect(response).to have_http_status(:not_found)
    end
  end
end
