class CreateRealEstates < ActiveRecord::Migration[7.0]
  def change
    create_table :real_estates do |t|
      t.string :title, null: false
      t.string :description
      t.string :address
      t.integer :estate_type, null: false
      t.integer :price, null: false
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
