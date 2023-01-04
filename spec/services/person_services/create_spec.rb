require 'rails_helper'

RSpec.describe PersonServices::Create, type: :service do
  subject { described_class.new(person: params) }

  let!(:user) { create(:user) }
  let!(:address) { create(:address) }

  let(:params) do
    {
      name: FFaker::NameBR.name,
      nickname: FFaker::NameBR.name,
      document_number: CPF.generate,
      cell_number: FFaker.numerify('###########'),
      telephone_number: FFaker.numerify('##########'),
      identity_document_type: ['rne', 'rg'].sample,
      identity_document_number: FFaker.numerify('#########'),
      identity_document_issuing_agency: 'SSP',
      marital_status: 'single',
      owner: user,
      birth_date: Date.today - 18.years,
      address_id: address.id
    }
  end

  shared_examples_for 'it creates a person' do
    it do
      expect do
        subject.call
      end.to change { Person.count }.by(1)

      person = Person.last

      expect(person.name).to eq(params[:name])
      expect(person.nickname).to eq(params[:nickname])
      expect(person.document_number).to eq(params[:document_number])
      expect(person.cell_number).to eq(params[:cell_number])
      expect(person.telephone_number).to eq(params[:telephone_number])
      expect(person.identity_document_type).to eq(params[:identity_document_type])
      expect(person.identity_document_number).to eq(params[:identity_document_number])
      expect(person.identity_document_issuing_agency).to eq(params[:identity_document_issuing_agency])
      expect(person.marital_status).to eq(params[:marital_status])
      expect(person.owner).to eq(params[:owner])
      expect(person.birth_date).to eq(params[:birth_date])
      expect(person.address_id).to eq(params[:address_id])
    end
  end

  describe '#call' do
    context 'when successful' do
      context 'when person does not exists' do
        it_behaves_like 'it creates a person'
      end

      context 'when person exists' do
        let!(:person) { create(:person, document_number: params[:document_number], owner: owner) }

        context 'when person has not same owner' do
          let!(:owner) { create(:address) }

          it_behaves_like 'it creates a person'
        end

        context 'when person has same owner' do
          let!(:owner) { user }

          it 'returns existing person' do
            expect do
              subject.call
            end.to raise_exception(ActiveRecord::RecordInvalid)
          end
        end
      end
    end
  end
end
