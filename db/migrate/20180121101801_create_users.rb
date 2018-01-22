class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :blockfolio_token, null: false
    end

    add_index :users, :blockfolio_token, unique: true
  end
end
