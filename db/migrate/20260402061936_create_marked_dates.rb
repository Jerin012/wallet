class CreateMarkedDates < ActiveRecord::Migration[8.1]
  def change
    create_table :marked_dates do |t|
      t.date :marked_on
      t.string :note

      t.timestamps
    end
  end
end
