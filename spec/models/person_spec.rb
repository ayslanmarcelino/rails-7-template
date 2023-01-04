# == Schema Information
#
# Table name: people
#
#  id                               :bigint           not null, primary key
#  birth_date                       :date
#  cell_number                      :string
#  deleted_at                       :datetime
#  document_number                  :string
#  identity_document_issuing_agency :string
#  identity_document_number         :string
#  identity_document_type           :string
#  marital_status                   :string
#  name                             :string
#  nickname                         :string
#  owner_type                       :string
#  telephone_number                 :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  address_id                       :bigint
#  owner_id                         :bigint
#
# Indexes
#
#  index_people_on_address_id  (address_id)
#  index_people_on_deleted_at  (deleted_at)
#  index_people_on_owner       (owner_type,owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { described_class.new(document_number: document_number, owner: owner) }

  let!(:document_number) { CPF.generate }
  let!(:owner) { create(:user) }

  context 'when sucessful' do
    context 'when there is no person with the same document_number and owner_type' do
      it { expect(subject).to be_valid }
    end
  end

  context 'when unsucessful' do
    context 'when has person with same document_number and owner_type' do
      let!(:person) { create(:person, document_number: document_number, owner_type: owner.class) }

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
  end
end
