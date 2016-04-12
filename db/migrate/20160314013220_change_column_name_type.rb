class ChangeColumnNameType < ActiveRecord::Migration
  def change
    rename_column :subscribers, :type, :subscriber_type
  end
end
