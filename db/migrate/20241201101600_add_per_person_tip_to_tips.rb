class AddPerPersonTipToTips < ActiveRecord::Migration[8.0]
  def change
    add_column :tips, :per_person_tip, :decimal
  end
end
