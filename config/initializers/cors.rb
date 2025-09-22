Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 本番: *.vercel.app と、個別指定 FRONTEND_ORIGIN
    extra = ENV.fetch("FRONTEND_ORIGIN", nil)

    origins vercel_regex,
            extra,
            "http://localhost:5173", "http://127.0.0.1:5173"  # 開発用

    resource "/api/*",
             headers: :any,
             methods: %i[get post patch put delete options]
  end
end
