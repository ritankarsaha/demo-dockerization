
require 'rack/test'
require 'rspec'
require_relative '../app/app'  

ENV['RACK_ENV'] = 'test'

RSpec.describe 'Enhanced Sample Project App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns a welcome message on GET /" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Hello, world!")
  end

  it "returns a JSON health status on GET /health" do
    get '/health'
    expect(last_response).to be_ok
    data = JSON.parse(last_response.body)
    expect(data["status"]).to eq("ok")
    expect(data).to have_key("timestamp")
  end
end
