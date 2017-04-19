class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :one
      t.string :two
      t.string :three
      t.string :four
      t.string :five
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
