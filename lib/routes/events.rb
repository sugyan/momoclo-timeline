require 'sinatra/base'
require 'haml'

class App < Sinatra::Base
  get '/events' do
    page = params[:page].to_i
    haml :'events/index', :locals => {
      :dataset => Event
        .order(:startdate.desc)
        .paginate(page > 0 ? page : 1, 30)
    }
  end
end
