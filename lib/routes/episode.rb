require 'sinatra/base'
require 'haml'

class App < Sinatra::Base
  get '/episode/new' do
    haml :'episode/new', :locals => { :params => {}, :errors => {} }
  end

  post '/episode/new' do
    if datetype = params.delete('datetype')
      params['startdate'] = params.delete('startdate' + datetype)
      if datetype == '1'
        params['enddate'] = (Date.parse(params['startdate']) >> 1) - 1
      end
    end
    logger.info params
    episode = Episode.new(params)
    if episode.valid?
      e = session[:user].add_episode(params)
      redirect "/episode/#{ e.id }"
    else
      haml :'episode/new', :locals => {
        :params => request.params,
        :errors => episode.errors,
      }
    end
  end

  get '/episode/:id' do
    if e = Episode[params[:id]]
      haml :'episode/index', :locals => { :episode => e }
    else
      not_found
    end
  end
end
