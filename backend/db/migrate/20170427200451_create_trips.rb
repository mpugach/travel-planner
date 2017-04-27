class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.string :destination
      t.text :comment
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
