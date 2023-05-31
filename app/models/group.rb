class Group < ApplicationRecord
  validates :name, presence: true
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :expense_groups, dependent: :destroy
  has_many :expenses, through: :expense_groups, dependent: :destroy

  def total_amount_by_group(group_id)
    expenses.joins(:expense_groups).where(expense_groups: { group_id: }).sum('expenses.amount')
  end
end
