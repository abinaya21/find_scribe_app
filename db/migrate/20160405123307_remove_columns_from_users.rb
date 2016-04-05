class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :educational_institution
  	remove_column :users, :languages_known
  	remove_column :users, :is_volunteer
  end

  def down
  end
end
