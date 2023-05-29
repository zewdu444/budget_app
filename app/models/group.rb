class Group <ApplicationRecord
  validates :name, presence: true
  validates :icon, presence: true
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :expense_groups, dependent: :destroy
  has_many :expenses, through: :expense_groups, dependent: :destroy
end
