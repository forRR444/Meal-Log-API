
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    allowed = [
      %r{\Ahttps://.*\.vercel\.app\z},      # Vercel 本番
      ENV["FRONTEND_ORIGIN"],
      "http://localhost:5173",
      "http://127.0.0.1:5173"
    ].compact   #（nil を除外）

    origins(*allowed)

    resource "/api/*",
             headers: :any,
             methods: %i[get post patch put delete options]
  end
end
