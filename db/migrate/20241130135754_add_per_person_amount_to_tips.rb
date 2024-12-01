class AddPerPersonAmountToTips < ActiveRecord::Migration[8.0]
  def change
    add_column :tips, :per_person_amount, :decimal
  end
end
