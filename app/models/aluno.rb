# frozen_string_literal: true

class Aluno < ApplicationRecord
  belongs_to :sala
  has_many :trabalhos

  validates_presence_of :nome
  validates_presence_of :rm
end
