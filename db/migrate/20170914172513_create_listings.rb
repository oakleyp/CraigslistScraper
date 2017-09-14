class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.decimal :price
      t.timestamp :issue_date

      t.timestamps
    end
  end
end
