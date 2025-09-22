module Api
  class SessionsController < ActionController::API
    # ログイン処理: email と password を認証して JWT を返す
    def create
      email = params[:email].to_s.strip.downcase
      user  = User.find_by("LOWER(email) = ?", email)

      if user&.authenticate(params[:password].to_s)
        # 認証成功 → JWT 発行
        payload = { sub: user.id, exp: 24.hours.from_now.to_i }
        secret  = Rails.application.credentials.jwt_secret || ENV['JWT_SECRET'] || 'change-me'
        token   = JWT.encode(payload, secret, 'HS256')

        render json: {
          token: token,
          user: {
            id: user.id,
            nickname: user.nickname,
            email: user.email
          }
        }
      else
        # 認証失敗 → エラー返却
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
end
