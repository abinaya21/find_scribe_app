class ModifyLanguageOnVolunteers < ActiveRecord::Migration
  def up
  	remove_column :volunteers, :languages_known
  	add_column :volunteers, :languages_known, :string
  end

  def down
  end
end
