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
#  index_people_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
class Person < ApplicationRecord
  IDENTITY_DOCUMENT_TYPES = [:RG, :RNE].freeze

  belongs_to :address, optional: true

  accepts_nested_attributes_for :address

  has_one :user

  validates :document_number, uniqueness: { scope: [:kind] }, if: -> { document_number.present? }
  validates :document_number, presence: true

  def self.permitted_params
    [
      :birth_date,
      :cell_number,
      :document_number,
      :identity_document_issuing_agency,
      :identity_document_number,
      :identity_document_type,
      :kind,
      :marital_status,
      :name,
      :nickname,
      :telephone_number,
      :address_id
    ]
  end
end
