class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Devise のデフォルトカラム
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## 追加カラム
      t.string :username, null: false  # ユーザー名
      t.string :full_name, null: false  # フルネーム
      t.string :furigana, null: false  # フリガナ
      t.date   :birth_date, null: false  # 生年月日
      t.string :address  # 住所
      t.json   :role, null: false  # 複数の役割を保持
      t.text   :experience, null: false  # 経験
      t.string :qualification  # 資格
      t.string :avatar  # アバター画像

      ## Devise のトークンなど
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :username, unique: true
  end
end