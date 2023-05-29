class User <ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  has many :expenses, foriegn_key: :author_id,  dependent: :destroy
  has many :groups, foriegn_key: :author_id,  dependent: :destroy

end
