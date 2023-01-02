class AddDeletedAtToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :deleted_at, :datetime
    add_index :addresses, :deleted_at
  end
end
