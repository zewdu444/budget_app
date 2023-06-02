class CreateExpenseGroup < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_groups do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
