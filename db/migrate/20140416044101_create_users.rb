class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :interests
      t.string :quotes
      t.string :aboutyourself

      t.timestamps
    end
  end
end
