Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    extra = ENV["FRONTEND_ORIGIN"] # 未設定なら nil

    allowed = [
      %r{\Ahttps://.*\.vercel\.app\z},          # Vercel の本番/プレビュー全部
      "http://localhost:5173",
      "http://127.0.0.1:5173"
    ]
    allowed << extra if extra # nil は入れない

    origins(*allowed)

    resource "/api/*",
             headers: :any,
             methods: %i[get post patch put delete options]
  end
end
