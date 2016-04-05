class RemoveUserIdFromServiceRequests < ActiveRecord::Migration
  def up
  	remove_column :service_requests, :user_id
  end

  def down
  end
end
