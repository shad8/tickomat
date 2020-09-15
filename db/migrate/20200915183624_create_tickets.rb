class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :selling_option
      t.integer :quantity
      t.decimal :price
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
