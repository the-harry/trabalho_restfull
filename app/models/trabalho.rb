class Trabalho < ApplicationRecord
  belongs_to :aluno

  validates_presence_of :title
  validates_presence_of :url
end
