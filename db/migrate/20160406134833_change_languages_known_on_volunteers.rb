class ChangeLanguagesKnownOnVolunteers < ActiveRecord::Migration
  def up
  	change_column :volunteers, :languages_known, :text, array: true
  end

  def down
  end
end
