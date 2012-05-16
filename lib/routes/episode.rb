require 'sinatra/base'
require 'haml'

class App < Sinatra::Base

  def process_date(p)
    if datetype = p.delete('datetype')
      p['startdate'] = p.delete('startdate' + datetype)
      if datetype == '1'
        p['enddate'] = (Date.parse(p['startdate']) >> 1) - 1
      else
        p['enddate'] = nil
      end
    end
  end

  get '/episode/new' do
    haml :'episode/new', :locals => { :params => {}, :errors => {} }
  end

  post '/episode/new' do
    process_date(params)
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
      not_found 'Not Found'
    end
  end

  get '/episode/:id/edit' do
    if (e = Episode[params[:id]]) && session[:user] && session[:user][:id] == e.user_id
      params = {
        'type'     => e.type.to_s,
        'text'     => e.text,
        'datetype' => e.enddate ? '1' : '0',
      }
      params["startdate#{ params['datetype'] }"] = e.startdate.to_s
      haml :'episode/new', :locals => {
        :params => params,
        :errors => {},
      }
    else
      not_found 'Not Found'
    end
  end

  post '/episode/:id/edit' do
    if e = Episode[params[:id]]
      if session[:user] && session[:user][:id] == e.user_id
        process_date(params)
        logger.info params
        e.set_fields(params, ['type', 'startdate', 'enddate', 'text'])
        if e.valid?
          e.update_only(params)
          redirect "/episode/#{ e.id }"
        else
          haml :'episode/new', :locals => {
            :params => request.params,
            :errors => e.errors,
          }
        end
      else
        error 400, 'Bad Request'
      end
    else
      not_found 'Not Found'
    end
  end

  post '/episode/:id/delete' do
    if e = Episode[params[:id]]
      if session[:user] && session[:user][:id] == e.user_id
        logger.info 'delete: ' + e.delete.id.to_s
        redirect '/'
      else
        error 400, 'Bad Request'
      end
    else
      not_found 'Not Found'
    end
  end
end
