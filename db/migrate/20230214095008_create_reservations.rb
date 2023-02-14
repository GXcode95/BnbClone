class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :checkin, null: false
      t.date :checkout, null: false
      t.references :real_estate, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: { to_table: :users }
      t.boolean :validated, default: false

      t.timestamps
    end
  end
end
