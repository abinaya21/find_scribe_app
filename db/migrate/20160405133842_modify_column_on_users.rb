class ModifyColumnOnUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :volunteer?, :volunteer
  end

  def down
  end
end
