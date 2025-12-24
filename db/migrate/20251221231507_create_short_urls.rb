class CreateShortUrls < ActiveRecord::Migration[8.1]
  def change
    create_table :short_urls do |t|
      t.string :code, null: false
      t.string :target_url, null: false
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end

    add_index :short_urls, :code, unique: true
  end
end
