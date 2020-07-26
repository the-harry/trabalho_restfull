# frozen_string_literal: true

FactoryBot.define do
  factory :aluno do
    sequence(:nome) { |n| "Aluno #{n}" }
    sequence(:rm) { |n| "123#{n}".to_i }
    sala
  end
end
