# 機密情報（パスワードやトークンなど）がログに出ないようにフィルタする設定
Rails.application.config.filter_parameters += [
  :passw, :email, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn, :cvv, :cvc
]
