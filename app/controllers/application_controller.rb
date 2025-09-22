class ApplicationController < ActionController::API
  # JWTエラー（不正トークン・有効期限切れ）発生時に共通で unauthorized! を返す
  rescue_from JWT::DecodeError, JWT::ExpiredSignature, with: :unauthorized!

  attr_reader :current_user # 現在認証中のユーザーを保持する

  private
  # JWTの秘密鍵を取得
  def jwt_secret
    Rails.application.credentials.jwt_secret || ENV['JWT_SECRET'] || 'change-me'
  end
  # ユーザー認証
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return unauthorized! unless token
    # JWTデコードしてユーザーを特定
    payload, = JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
    uid = payload['sub'] || payload['user_id'] || payload['uid']
    @current_user = User.find_by(id: uid)
    return unauthorized! unless @current_user
  rescue JWT::DecodeError, JWT::ExpiredSignature
    unauthorized!
  end
  # 認証失敗時のレスポンス
  def unauthorized!
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
