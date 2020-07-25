# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Aluno pode ver um trabalho enviado', type: :request do
  context 'success 200' do
    it 'responde com o id do trabalho' do
      aluno = Aluno.create(nome: 'foo', rm: 123, sala: Sala.create(nome: 'bar'))
      trabalho = Trabalho.create(title: 'NAC', url: 'localhost', aluno: aluno)

      get "/api/v1/trabalho/#{trabalho.id}"

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(trabalho.id)
      expect(parsed_response['title']).to eq(trabalho.title)
      expect(parsed_response['url']).to eq(trabalho.url)
      expect(parsed_response['aluno_id']).to eq(aluno.id)
    end
  end

  context 'record found 404' do
    it 'raises error if no title is suplied' do
      get '/api/v1/trabalho/42'

      expect(response).to have_http_status(:not_found)
    end
  end
end
