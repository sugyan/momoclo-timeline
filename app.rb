require 'sinatra/base'
require 'rack/csrf'
require 'haml'

class App < Sinatra::Base
  configure do
    enable :logging
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    set :haml, :escape_html => true
    use Rack::Csrf, :raise => true
  end

  get '/' do
    haml :index
  end

  get '/timeline' do
    haml :timeline
  end

  get '/about' do
    haml :about
  end
end

require_relative './lib/model'
require_relative './lib/routes/api'
require_relative './lib/routes/auth'
require_relative './lib/routes/events'
require_relative './lib/routes/episode'
