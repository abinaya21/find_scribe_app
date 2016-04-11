class ModifyVolunteerColumnOnUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :volunteer, :is_volunteer
  end

  def down
  end
end
