class Api::MeController < ApplicationController
  # 認証が必要なエンドポイント
  before_action :authenticate_user!
  # 現在ログイン中のユーザー情報を返す（email, nickname）
  def show
    user = current_user
    render json: { email: user.email, nickname: user.nickname }
  end
end
