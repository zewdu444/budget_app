class Expense <ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :expense_groups, dependent: :destroy
  has_many :groups, through: :expense_groups, dependent: :destroy

   after_save :total_amount_by_group
   after_destroy :total_amount_by_group

  def total_amount_by_group(group)
    expense_groups.where(group: group).sum(:amount)
  end

  private :total_amount_by_group
end
