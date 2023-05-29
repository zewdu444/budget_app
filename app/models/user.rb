class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  has_many :expenses, foreign_key: :author_id, dependent: :destroy
  has_many :groups, foreign_key: :author_id, dependent: :destroy
end
