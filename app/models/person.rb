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
class Person < ApplicationRecord
  IDENTITY_DOCUMENT_TYPES = [:RG, :RNE].freeze

  acts_as_paranoid

  belongs_to :address, optional: true, dependent: :destroy
  belongs_to :owner, polymorphic: true, optional: true

  accepts_nested_attributes_for :address

  has_one :user

  validates :document_number, uniqueness: { scope: :owner_type }, if: -> { document_number.present? }
  validates :document_number, presence: true

  def self.permitted_params
    [
      :birth_date,
      :cell_number,
      :document_number,
      :identity_document_issuing_agency,
      :identity_document_number,
      :identity_document_type,
      :owner,
      :marital_status,
      :name,
      :nickname,
      :telephone_number,
      :address_id
    ]
  end
end
