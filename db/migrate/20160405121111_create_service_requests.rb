class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.string :city
      t.string :user_id
      t.date :date
      t.time :start_time
      t.time :to_time
      t.integer :user_id
      t.string :language

      t.timestamps
    end
  end
end
