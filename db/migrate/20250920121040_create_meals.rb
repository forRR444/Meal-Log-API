class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    # 食事記録テーブルを作成（ユーザーに紐づく食事内容を管理）
    create_table :meals do |t|
      t.references :user, null: false, foreign_key: true
      t.date    :eaten_on,    null: false
      t.integer :kind,        null: false, default: 0
      t.string  :name,        null: false
      t.integer :amount_grams
      t.integer :calories_kcal
      t.text    :notes
      t.timestamps
    end
    add_index :meals, [ :user_id, :eaten_on, :kind ]
  end
end
