# frozen_string_literal: true

FactoryBot.define do
  factory :trabalho do
    title { 'Trabalho de IOT' }
    url { 'https://github.com/user/repo' }
    aluno
  end
end
