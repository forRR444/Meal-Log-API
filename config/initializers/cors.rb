Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173", "http://127.0.0.1:5173"
    resource "/api/*", headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
  end
end
