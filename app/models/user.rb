class User < ApplicationRecord
  has_secure_password  # パスワードを安全に管理
  has_many :meals, dependent: :destroy # Mealモデルと1対多、ユーザー削除時に食事記録も削除

  validates :email, presence: true, uniqueness: true # メールアドレス必須＆一意
  validates :nickname, presence: true # ニックネーム必須
end
