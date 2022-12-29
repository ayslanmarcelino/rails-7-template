module PersonServices
  class Create < ApplicationService
    def initialize(params:)
      @params = params
      @document_number = params[:document_number]
      @kind = params[:kind]
    end

    def call
      find_or_create!
    end

    private

    def find_or_create!
      return person if person

      Person.create!(
        document_number: @document_number,
        name: @params[:name],
        nickname: @params[:nickname],
        cell_number: @params[:cell_number],
        telephone_number: @params[:telephone_number],
        identity_document_type: @params[:identity_document_type],
        identity_document_number: @params[:identity_document_number],
        identity_document_issuing_agency: @params[:identity_document_issuing_agency],
        marital_status: @params[:marital_status],
        kind: @params[:kind],
        birth_date: @params[:birth_date],
        address_id: @params[:address_id]
      )
    end

    def person
      Person.find_by(document_number: @document_number, kind: @kind)
    end
  end
end
