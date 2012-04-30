#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'json'
require 'nokogiri'
require 'open-uri'

data = []
doc = Nokogiri::HTML(open('http://www.momoclo.net/schedule/tourschedule.html'))
doc.css('#midashi_01').reverse.each_with_index do |midashi, i|
  title = midashi.children.grep(Nokogiri::XML::Text).map{|e| e.text }.join
  title.gsub!(/.*「(.+)」.*/m, '\1')
  title.strip!

  array = []
  case i
  when 0
    midashi.parent.parent.next.css('table table tr').each do |tr|
      text = tr.css('td')[0].text.strip.gsub(/　+$/, '')
      next unless text.match(/月.*日/)
      date, place = text.split(/[ 　]+/, 2)
      match = date.tr('０-９', '0-9').match(/(\d+)月(\d+)日/)
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2009, match[1].to_i, match[2].to_i),
          :name      => [title, place].join(' '),
        })
    end
  when 1
    midashi.parent.parent.next.css('table')[1].css('tr').each do |tr|
      td = tr.css('td')
      date = td[0].text.strip.gsub(/　+$/, '')
      next unless date.match(/月.*日/)
      match = date.tr('０-９', '0-9').match(/(\d+)月(\d+)日/)
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2009, match[1].to_i, match[2].to_i),
          :name      => [title, td[1].text.gsub(/[ 　\n]+/, ' ')].join(' '),
        })
    end
  when 2
    midashi.parent.parent.next.css('span').each do |span|
      text = span.text
      next unless text.match(/月.*日/)
      date, place = text.split(/（.*?[）\)]　/)
      match = date.gsub(/　/, '').tr('０-９', '0-9').match(/(\d+)月(\d+)日/)
      array.push({
          :id         => 1000 + i * 100 + array.length + 1,
          :startdate  => Date.new(2010, match[1].to_i, match[2].to_i),
          :name       => [title, place].join(' '),
        })
    end
  when 3
    midashi.parent.parent.next.css('table tr').each do |tr|
      td = tr.css('td')
      match = td[0].text.match(/(\d)\/(\d+)/)
      next unless match
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2010, match[1].to_i, match[2].to_i),
          :name      => [title, td[2].text].join(' '),
        })
    end
  when 4
    midashi.parent.parent.next.css('table tr').each do |tr|
      td = tr.css('td')
      match = td[1].text.match(/(\d+)月(\d+)日/)
      next unless match
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2010, match[1].to_i, match[2].to_i),
          :name      => [title, td[3].text.gsub(/\n.*$/, '').gsub(/※.*$/, '').gsub(/　+$/, '')].join(' '),
        })
    end
  when 5
    midashi.parent.css('p')[2].children.collect_concat do |e|
      e.children.length > 0 ? e.children : [e]
    end.each do |e|
      line  = e.text
      match = line.match(/(\d)\/(\d{2})/)
      next unless match
      date = Date.new(2011, match[1].to_i, match[2].to_i)
      next if date >= Date.new(2011, 3, 11)
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => date,
          :name      => [title, line.strip.split(/　/, 2)[1].gsub(/　【.*$/, '')].join(' '),
        })
    end
  when 6
    midashi.next.css('span').each do |span|
      date, place = span.text.gsub(/　+$/, '').split(/　/)
      match = date.match(/(\d)月(\d{2})日/)
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2011, match[1].to_i, match[2].to_i),
          :name      => [title, place].join(' '),
        })
    end
  when 7
    midashi.next.next.css('span.eventtitle2').each do |span|
      text  = span.text.strip
      match = text.match(/(\d{2})月(\d{2})日/)
      next unless match
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2011, match[1].to_i, match[2].to_i),
          :name      => [title, text.split(/）　/)[1].gsub(/　+$/, '')].join(' '),
        })
    end
  when 8
    midashi.next.next.css('span.eventtitle2').each do |span|
      text  = span.text
      match = text.match(/(\d{2})月(\d{2})日/)
      next unless match
      array.push({
          :id        => 1000 + i * 100 + array.length + 1,
          :startdate => Date.new(2012, match[1].to_i, match[2].to_i),
          :name      => [title, text.split(/（.）/)[1]].join(' ')
        })
    end
  end

  array.sort_by!{|obj| obj[:startdate]}
  array.unshift({
      :id         => 1000 + i * 100,
      :name       => title,
      :startdate  => array[0][:startdate],
      :enddate    => array[-1][:startdate],
      :importance => 30,
    })
  data.concat(array)
end

puts JSON.pretty_generate(data)
