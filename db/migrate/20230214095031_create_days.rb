class CreateDays < ActiveRecord::Migration[7.0]
  def change
    create_table :days do |t|
      t.date :date, null: false
      t.boolean :taken, null: false, default: false
      t.references :real_estate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
