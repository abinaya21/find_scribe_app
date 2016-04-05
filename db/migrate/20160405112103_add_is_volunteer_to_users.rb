class AddIsVolunteerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_volunteer, :boolean
  end
end
