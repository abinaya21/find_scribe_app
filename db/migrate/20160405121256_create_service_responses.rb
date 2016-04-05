class CreateServiceResponses < ActiveRecord::Migration
  def change
    create_table :service_responses do |t|
      t.integer :service_request_id
      t.integer :volunteer_id

      t.timestamps
    end
  end
end
