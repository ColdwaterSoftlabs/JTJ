class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :discourse_email
      t.string :token

      t.timestamps
    end
  end
end
