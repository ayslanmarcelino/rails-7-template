module UserServices
  class Create < ApplicationService
    def initialize(params:, person:)
      @params = params
      @person = person
    end

    def call
      find!
      create!
    end

    private

    def create!
      User.create!(
        email: @params[:email],
        password: @params[:password],
        person: person
      )
    end

    def find!
      return unless ensure_person_has_one_user!

      raise("Pessoa já possui um usuário cadastrado com o e-mail: #{@person.owner.email}")
    end

    def ensure_person_has_one_user!
      User.find_by(person: person)
    end

    def person
      PersonServices::Create.call(person: @person)
    end
  end
end
