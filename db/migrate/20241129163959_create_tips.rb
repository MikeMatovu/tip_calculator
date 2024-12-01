class CreateTips < ActiveRecord::Migration[8.0]
  def change
    create_table :tips do |t|
      t.decimal :bill
      t.integer :tip_percentage
      t.integer :number_of_people
      t.decimal :total
      t.decimal :tip_amount

      t.timestamps
    end
  end
end
