# frozen_string_literal: true

FactoryBot.define do
  factory :aluno do
    nome { 'individuo um' }
    rm { 1234 }
    sala
  end
end
