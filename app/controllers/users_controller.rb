class UsersController < ApplicationController
  # 新規ユーザーを作成し、成功時はJWTトークンとユーザー情報を返す
  def create
    user = User.new(user_params)

    if user.save
      payload = { sub: user.id, exp: 24.hours.from_now.to_i }
      token   = JWT.encode(payload, jwt_secret, "HS256")
      render json: { token: token, email: user.email, nickname: user.nickname }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # リクエストからユーザー登録に必要なパラメータを取得
  def user_params
    params.permit(:email, :password, :password_confirmation, :nickname)
  end

  # JWT用の秘密鍵を返す
  def jwt_secret
    ENV["JWT_SECRET"] || Rails.application.secret_key_base
  end
end
