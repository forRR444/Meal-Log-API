class Meal < ApplicationRecord
  belongs_to :user # Userモデルと関連付け（Mealは必ずUserに属する）

  enum :kind, { breakfast: 0, lunch: 1, dinner: 2, snack: 3 }, prefix: true
  # 必須項目チェック
  validates :eaten_on, :kind, :name, presence: true

  # 数値項目のバリデーション（nil可、整数のみ、0以上）
  validates :amount_grams, :calories_kcal,
            numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
end
