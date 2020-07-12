require "rails_helper"

RSpec.describe 'Aluno pode ver todos os trabalhos enviados', type: :request do

  context 'success 200' do
    it 'responde com o id do trabalho' do
      aluno = Aluno.create(nome: 'foo', rm: 123, sala: Sala.create(nome: 'bar'))
      trabalho = Trabalho.create(title: 'NAC', url: 'localhost', aluno: aluno)
      Trabalho.create(title: 'NAC2', url: 'localhost', aluno: aluno)

      get "/api/v1/trabalhos"

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(2)
      expect(parsed_response[0]['id']).to eq(trabalho.id)
      expect(parsed_response[0]['title']).to eq(trabalho.title)
      expect(parsed_response[0]['url']).to eq(trabalho.url)
      expect(parsed_response[0]['aluno_id']).to eq(aluno.id)
    end
  end

  context 'no record found 204' do
    it "raises error if no title is suplied" do
      get "/api/v1/trabalhos"

      expect(response).to have_http_status(:no_content)
    end
  end
end
