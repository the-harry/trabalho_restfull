# frozen_string_literal: true

FactoryBot.define do
  factory :sala do
    sequence(:nome) { |n| "Sala #{n}" }
  end
end
