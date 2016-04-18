class ChangeInvalidFlagOnServiceResponse < ActiveRecord::Migration
  def up
  	rename_column :service_responses, :invalid, :response_invalid
  end

  def down
  end
end
