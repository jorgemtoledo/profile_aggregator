class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :github_username, null: false
      t.string :github_url, null: false

      t.timestamps
    end

    add_index :profiles, :github_username, unique: true
  end
end
