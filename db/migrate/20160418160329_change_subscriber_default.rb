class ChangeSubscriberDefault < ActiveRecord::Migration
  def change
    change_column_default :subscribers, :last_name, ""
    change_column_default :subscribers, :first_name, ""
    change_column_default :subscribers, :address, ""
    change_column_default :subscribers, :city, ""
    change_column_default :subscribers, :state, ""
    change_column_default :subscribers, :zip, ""
    change_column_default :subscribers, :home_phone, ""
    change_column_default :subscribers, :work_phone, ""
    change_column_default :subscribers, :start_date, ""
    change_column_default :subscribers, :mail_list, ""
    change_column_default :subscribers, :subscriber_type, ""
    change_column_default :subscribers, :notes, ""
    
    add_column :subscribers, :mobile_phone, :string, :default => ""
  end
end
