class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :username, null: false
      t.integer :followers_count, default: 0, null: false
      t.integer :following_count, default: 0, null: false
      t.integer :stars_count, default: 0, null: false
      t.integer :contributions_last_year, default: 0, null: false
      t.string :avatar_url, null: false
      t.string :organization
      t.string :location

      t.timestamps
    end

    add_index :profiles, :username, unique: true
  end
end
