module PopulatePersonKind
  extend ActiveSupport::Concern

  included do
    before_save :populate_person_kind
  end

  def populate_person_kind
    person.kind = self.class.name
  end
end
