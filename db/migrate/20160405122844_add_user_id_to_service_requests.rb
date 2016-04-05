class AddUserIdToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :user_id, :integer
  end
end
