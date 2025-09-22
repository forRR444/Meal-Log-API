class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    # ユーザー認証用テーブルを作成
    # email: ログインID（ユニーク制約あり）
    # password_digest: has_secure_password 用のハッシュ値
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
