require 'sinatra/base'
require 'omniauth-twitter'

class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']

    use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
    end
  end

  before '/episode/new' do
    logger.info session[:user]
    unless session[:user] && User[session[:user][:id]]
      session[:redirect] = request.url
      redirect '/auth/twitter'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/auth/twitter/callback' do
    auth = request.env['omniauth.auth']
    logger.info auth
    params = {
      :id          => auth.uid,
      :screen_name => auth.info.nickname,
      :name        => auth.info.name,
      :image       => auth.info.image,
      :description => auth.info.description,
    }
    logger.info params
    if user = User[params[:id]]
      user.update(params)
    else
      user = User.new(params)
      raise 'oauth error' if not user.valid?
      user.save
    end
    session[:user] = user
    redirect session[:redirect] || '/'
  end
end
