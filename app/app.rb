require 'sinatra'


get '/' do
  "Hello, world! This is an enhanced sample project demonstrating Docker, CI/CD, and Codespaces integration."
end


get '/health' do
  content_type :json
  { status: 'ok', timestamp: Time.now }.to_json
end
