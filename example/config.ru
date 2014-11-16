require 'bundler/setup'
require 'sinatra/base'
require 'omniauth/qiita'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/qiita'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :qiita,
            ENV['APP_ID'],
            ENV['APP_SECRET'],
            authorize_params: { scope: 'read_qiita' }
end

run App.new
