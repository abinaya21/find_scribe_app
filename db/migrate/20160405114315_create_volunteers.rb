class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.integer :languages_known
      t.integer :availability
      t.integer :user_id

      t.timestamps
    end
  end
end
