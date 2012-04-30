require 'sinatra/base'
require 'haml'
require 'omniauth-twitter'
require './model'

class App < Sinatra::Base
  enable :sessions, :logging
  set :haml, :escape_html => true
  set :session_secret, ENV['SESSION_SECRET']
  use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  end

  get '/' do
    haml :index, :locals => {
      :jss => ['http://static.simile.mit.edu/timeline/api-2.3.0/timeline-api.js?bundle=true', '/js/index.js'],
    }
  end

  get '/login' do
    redirect '/auth/twitter'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/auth/twitter/callback' do
    auth = request.env['omniauth.auth']
    session[:user] = {
      :id => auth.uid,
      :info => auth.info,
    }
    redirect '/'
  end

  get '/api/events.json' do
    OfficialEvent.to_json(:except => [:id], :naked => true)
  end
end
