# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Aluno, type: :model do
  it { is_expected.to validate_presence_of(:nome) }
  it { is_expected.to validate_presence_of(:rm) }
end
