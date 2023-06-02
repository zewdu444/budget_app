class Expense < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :expense_groups, dependent: :destroy
  has_many :groups, through: :expense_groups, dependent: :destroy
end
