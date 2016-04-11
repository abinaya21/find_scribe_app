class RemoveFieldFromVolunteers < ActiveRecord::Migration
  def up
  	remove_column :volunteers, :testing
  end

  def down
  end
end
