#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/array/grouping'

irregular = { 34646 => 'Ⅲ' }
html = open('http://www.momoclo.net/profile/profile.html', 'r:Shift_JIS').read
doc = Nokogiri::HTML(html.split(//).map{|c| irregular[c.ord] || c.encode('UTF-8')}.join(''))
doc.css('img[src="img/profile_live.jpg"]')[0].next.next.children.to_a.split do |e|
  e.name == 'img'
end[0].split do |e|
  e.name == 'br'
end.each do |arr|
  text = arr.map{ |e| e.text.strip }.join('')
  p text
end
