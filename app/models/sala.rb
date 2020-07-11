# frozen_string_literal: true

class Sala < ApplicationRecord
  has_many :alunos

  validates_presence_of :nome
end
