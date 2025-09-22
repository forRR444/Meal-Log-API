class AddNicknameToUsers < ActiveRecord::Migration[8.0]
  def change
    # ユーザー表示名を管理するためのカラムを追加（必須項目）
    add_column :users, :nickname, :string, null: false
  end
end
