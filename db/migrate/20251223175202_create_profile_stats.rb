class CreateProfileStats < ActiveRecord::Migration[8.1]
  def change
    create_table :profile_stats do |t|
      t.references :profile, null: false, foreign_key: true

      t.integer :followers_count, default: 0, null: false
      t.integer :following_count, default: 0, null: false
      t.integer :stars_count, default: 0, null: false
      t.integer :contributions_last_year, default: 0, null: false

      t.string :avatar_url
      t.string :organization
      t.string :location

      t.datetime :last_scraped_at

      t.timestamps
    end
  end
end
