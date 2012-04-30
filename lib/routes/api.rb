# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'sinatra/json'
require 'json'

class App < Sinatra::Base
  helpers Sinatra::JSON

  configure do
    set :json_encoder, :to_json
  end

  get '/api/timeglider.json' do
    json [{
        :id           => 'momoclo',
        :title        => 'momoclo timeline',
        :timezone     => '09:00',
        :focus_date   => Date.today(),
        :initial_zoom => 27,
        :events       => [].concat(OfficialEvent.filter{ importance >= 30 }.order(:startdate).each_with_index.map{|event, idx|
            hash = event.values.clone
            hash[:id]    = 'event:' + hash[:id].to_s
            hash[:title] = hash.delete(:name)
            hash[:link]  = "/timeline##{ idx }"
            hash[:icon]  = {
              35 => 'plus_gray.png',
              40 => 'star_black.png',
              45 => 'triangle_orange.png',
            }[hash[:importance]]
            hash
          }).concat(Episode.map{|episode|
            {
              :id          => 'episode:' + episode.id.to_s,
              :title       => '@' + episode.user.screen_name + ': ' + episode.text[0..30],
              :startdate   => episode.startdate,
              :enddate     => episode.enddate,
              :description => EpisodeType[episode.type].name,
              :link        => '/episode/' + episode.id.to_s,
              :css_class   => 'episode',
              :importance  => 30,
              :icon        => 'quote.png',
            }
          })
      }]
  end

  get '/api/timeline.json' do
    json :timeline => {
      :type => 'default',
      :date => OfficialEvent.filter{ importance >= 30 }.order(:startdate).map do |event|
        ret = {
          :startDate => event.startdate.strftime('%Y,%-m,%-d'),
          :endDate   => event.enddate ? event.enddate.strftime('%Y,%-m,%-d') : nil,
          :headline  => event.name,
          :text      => event.description,
        }
        ret[:asset] = { :media => event.image } if event.image
        ret
      end,
    }
  end
end
