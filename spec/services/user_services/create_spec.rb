require 'rails_helper'

RSpec.describe UserServices::Create, type: :service do
  subject { described_class.new(params: params, person: person) }

  let!(:person) { create(:person) }

  let(:params) do
    {
      email: FFaker::Internet.email,
      password: 'Password#123',
      person: person
    }
  end

  shared_examples_for 'it creates a user' do
    it do
      expect do
        subject.call
      end.to change { User.count }.by(1)

      user = User.last

      expect(user.email).to eq(params[:email])
      expect(user.person).to eq(params[:person])
    end
  end

  describe '#call' do
    context 'when successful' do
      it_behaves_like 'it creates a user'
    end

    context 'when unsuccessful' do
      context 'when has user with existing email' do
        let!(:user) { create(:user) }

        before { params[:email] = user.email }

        it do
          expect do
            subject.call
          end.to change { User.count }.by(0)
            .and raise_error('E-mail já está em uso')
        end
      end

      context 'when person has existing user' do
        let!(:user) { create(:user) }
        let!(:person) { user.person }

        it do
          expect do
            subject.call
          end.to change { User.count }.by(0)
            .and raise_error("Pessoa já possui um usuário cadastrado com o e-mail: #{person.user.email}")
        end
      end
    end
  end
end
