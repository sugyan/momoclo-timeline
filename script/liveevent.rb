#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'json'
require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/array/grouping'

year = nil
results = []
irregular = { 34646 => 'Ⅲ' }

html = open('http://www.momoclo.net/profile/profile.html', 'r:Shift_JIS').read
doc = Nokogiri::HTML(html.split(//).map{|c| irregular[c.ord] || c.encode('UTF-8')}.join(''))
doc.css('img[src="img/profile_live.jpg"]')[0].next.next.children.to_a.split do |e|
  e.name == 'img'
end[0].split do |e|
  e.name == 'br'
end.each do |arr|
  text = arr.map{ |e| e.text.strip }.join('')
  # year
  if text =~ /■(２０..)年/
    year = {
      '２００９' => 2009,
      '２０１０' => 2010,
      '２０１１' => 2011,
      '２０１２' => 2012,
    }[$1]
    next
  end
  next unless text.match(/：/)

  if m = text.match(/　　(\d{2})\/(\d{2})　：　(.*)$/)
    date = Date.new(year, m[1].to_i, m[2].to_i)
    next if {
      Date.new(2011,  4, 10) => true,
      Date.new(2011,  8, 20) => true,
      Date.new(2011, 10, 30) => true,
      Date.new(2011, 11,  6) => true,
      Date.new(2011, 12, 25) => true,
      Date.new(2012,  5,  5) => true,
    }[date]
    results.push({
        :id        => 5000 + results.length + 1,
        :startdate => date,
        :name      => m[3],
      })
  elsif m = text.match(/(\d{2})\/(\d+)〜([\d\/]+).*?　：　(.*)$/)
    startdate = Date.new(year, m[1].to_i, m[2].to_i)
    enddate   = nil
    next if {
      Date.new(2009,  5, 24) => true,
      Date.new(2009, 10,  3) => true,
      Date.new(2010,  3,  6) => true,
      Date.new(2010,  8, 21) => true,
      Date.new(2010,  9, 19) => true,
      Date.new(2011,  5, 20) => true,
      Date.new(2011, 11, 12) => true,
      Date.new(2012,  4, 21) => true,
    }[startdate]
    if mm = m[3].match(/(\d{2})\/(\d{2})/)
      enddate = Date.new(year, mm[1].to_i, mm[2].to_i)
    else
      enddate = Date.new(year, startdate.month, m[3].to_i)
    end
    results.push({
        :id        => 5000 + results.length + 1,
        :startdate => startdate,
        :enddate   => enddate,
        :name      => m[4]
      })
  elsif m = text.match(/(\d{2})\/(\d{2}),(\d{2})　：　(.*)$/)
    startdate = Date.new(year, m[1].to_i, m[2].to_i)
    enddate   = Date.new(year, m[1].to_i, m[3].to_i)
    results.push({
        :id        => 5000 + results.length + 1,
        :startdate => startdate,
        :enddate   => enddate,
        :name      => m[4]
      })
  else
    # no use
  end
end

puts JSON.pretty_generate(results)
