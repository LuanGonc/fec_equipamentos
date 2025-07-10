require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Collaborator, type: :model do
  subject { build(:collaborator) }

  it 'é válido com todos os atributos obrigatórios' do
    expect(subject).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:department) }

  describe 'validações de unicidade' do
    let!(:existing_colab) { create(:collaborator) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  it { should have_many(:loans).dependent(:destroy) }
end
