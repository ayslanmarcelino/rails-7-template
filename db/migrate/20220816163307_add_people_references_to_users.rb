class AddPeopleReferencesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :person, index: true, foreign_key: true
  end
end
