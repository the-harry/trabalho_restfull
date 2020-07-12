require 'rails_helper'

RSpec.describe Trabalho, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }
end
