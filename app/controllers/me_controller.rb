class MeController < ApplicationController
  # ログインユーザーのみアクセス可能
  before_action :authenticate!

  def show
    # 現在ログイン中のユーザー情報を返す
    user = current_user
    render json: { email: user.email, nickname: user.nickname }
  end
end
