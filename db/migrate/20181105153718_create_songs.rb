class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :item, foreign_key: true
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
