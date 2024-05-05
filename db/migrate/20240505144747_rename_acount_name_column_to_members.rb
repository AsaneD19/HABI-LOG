class RenameAcountNameColumnToMembers < ActiveRecord::Migration[6.1]
  def change
    rename_column :members, :acount_name, :account_name
  end
end
