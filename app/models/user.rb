class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :job_posts, dependent: :destroy  # 施工管理者が作成した案件
  has_many :job_applications, dependent: :destroy  # 作業員が応募した案件

  # バリデーション
  validates :username, presence: true
  validates :full_name, presence: true
  validates :furigana, presence: true
  validates :birth_date, presence: true
  validates :address, presence: true
  validates :role, presence: true
  validates :experience, presence: true
  validates :qualification, presence: true
end
