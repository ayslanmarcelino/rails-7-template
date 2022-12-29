# == Schema Information
#
# Table name: people
#
#  id                               :bigint           not null, primary key
#  birth_date                       :date
#  cell_number                      :string
#  document_number                  :string
#  identity_document_issuing_agency :string
#  identity_document_number         :string
#  identity_document_type           :string
#  kind                             :string
#  marital_status                   :string
#  name                             :string
#  nickname                         :string
#  telephone_number                 :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  address_id                       :bigint
#
# Indexes
#
#  index_people_on_address_id  (address_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { described_class.new(document_number: document_number, kind: kind) }

  let(:document_number) { CNPJ.generate }
  let(:kind) { 'user' }

  context 'when sucessful' do
    context 'when has person with same document_number' do
      let!(:person) { create(:person, kind: 'other_kind', document_number: document_number) }

      context 'when has same kind' do
        it do
          expect(subject).to be_valid
        end
      end
    end

    context 'when does not have same document_number with same kind' do
      let!(:person) { create(:person, kind: kind) }

      it do
        expect(subject).to be_valid
      end
    end
  end

  context 'when unsucessful' do
    context 'when has person with same document_number and kind' do
      let!(:person) { create(:person, document_number: document_number, kind: kind) }

      it do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.to_sentence).to eq('CPF já está em uso')
      end
    end

    context 'when do not pass document_number' do
      let(:document_number) {}

      it do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.to_sentence).to eq('CPF não pode ficar em branco')
      end
    end

    context 'when do not pass kind' do
      let(:kind) {}

      it do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.to_sentence).to eq('Tipo não pode ficar em branco')
      end
    end
  end
end
