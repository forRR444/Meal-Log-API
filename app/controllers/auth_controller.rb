class AuthController < ApplicationController
  # ログイン処理
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      # JWTトークンを発行（有効期限24時間）
      token = jwt_encode({ sub: user.id, exp: 24.hours.from_now.to_i })
      render json: { token: token }, status: :ok
    else
      # 認証失敗
      render json: { error: 'invalid_credentials' }, status: :unauthorized
    end
  end

  private
  # JWTの秘密鍵を取得（環境変数優先）
  def jwt_secret
    ENV["JWT_SECRET"] || Rails.application.secret_key_base
  end
  # JWTトークンを生成
  def jwt_encode(payload)
    JWT.encode(payload, jwt_secret, 'HS256')
  end
end
