class RenameColumnInServiceRequest < ActiveRecord::Migration
  def up
  	rename_column :service_requests, :to_time, :end_time
  end

  def down
  end
end
