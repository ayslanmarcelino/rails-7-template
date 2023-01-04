module PersonServices
  class Create < ApplicationService
    def initialize(person:)
      @person = person
    end

    def call
      find_or_create!
    end

    private

    def find_or_create!
      return @person if @person.is_a?(ActiveRecord::Base) && @person.persisted?

      Person.create!(
        document_number: @person[:document_number],
        name: @person[:name],
        nickname: @person[:nickname],
        cell_number: @person[:cell_number],
        telephone_number: @person[:telephone_number],
        identity_document_type: @person[:identity_document_type],
        identity_document_number: @person[:identity_document_number],
        identity_document_issuing_agency: @person[:identity_document_issuing_agency],
        marital_status: @person[:marital_status],
        owner: @person[:owner],
        birth_date: @person[:birth_date],
        address_id: @person[:address_id]
      )
    end
  end
end
