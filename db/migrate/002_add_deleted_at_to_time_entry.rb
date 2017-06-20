class AddDeletedAtToTimeEntry < ActiveRecord::Migration
  def up
    add_column :time_entries, :deleted_at, :datetime
    add_index :time_entries, :deleted_at
  end

  def down
    remove_column :time_entries, :deleted_at, :datetime
    remove_index :time_entries, :deleted_at
  end
end
