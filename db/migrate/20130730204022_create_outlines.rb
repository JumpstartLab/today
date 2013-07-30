class CreateOutlines < ActiveRecord::Migration
  def change
    create_table :outlines do |t|
      t.string :title
      t.text :body
      t.date :publish_date

      t.timestamps
    end
  end
end
