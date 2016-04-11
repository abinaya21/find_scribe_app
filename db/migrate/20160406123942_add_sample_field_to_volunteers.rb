class AddSampleFieldToVolunteers < ActiveRecord::Migration
  def change
  	add_column :volunteers, :testing, :boolean
  end
end
