class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :parent, foreign_key: { to_table: :items }

      t.string :name
      t.string :description
      t.string :type
      t.string :format

      t.jsonb :fields

      t.datetime :released_at
      t.timestamps
    end
  end
end
