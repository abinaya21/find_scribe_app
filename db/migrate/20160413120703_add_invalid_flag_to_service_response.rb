class AddInvalidFlagToServiceResponse < ActiveRecord::Migration
  def change
  	add_column :service_responses, :invalid, :boolean, default: false
  end
end
