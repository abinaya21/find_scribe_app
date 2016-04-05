class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact_no
      t.date :dob
      t.string :gender
      t.string :city
      t.text :address
      t.string :educational_institution
      t.string :languages_known

      t.timestamps
    end
  end
end
