#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'sequel'
require 'json'


db = Sequel.connect(ENV['SHARED_DATABASE_URL'])
db[:official_events].delete
# tour schedule from json
data = JSON.load(File.read(File.dirname(__FILE__) + '/../data/tourschedule.json'))
db[:official_events].insert_multiple(data)
# fixed data
db[:official_events].insert_multiple([{
      :id          => 0,
      :name        => 'ももいろクローバー 結成',
      :startdate   => Date.new(2008, 5, 17),
      :importance  => 45,
    }, {
      :id          => 1,
      :name        => 'ももいろクリスマス in 日本青年館 ~脱皮:DAPPI~',
      :startdate   => Date.new(2010, 12, 24),
      :image       => 'http://www.momoclo.net/discography/img/momokuri_dvd.jpg',
      :description => '日本青年館',
      :importance  => 40,
    }, {
      :id          => 2,
      :name        => '4.10中野サンプラザ大会 ももクロ春の一大事 ~眩しさの中に君がいた~',
      :startdate   => Date.new(2011, 4, 10),
      :image       => 'http://www.momoclo.net/discography/img/nakano410.jpg',
      :description => '中野サンプラザ',
      :importance  => 40,
    }, {
      :id          => 3,
      :name        => 'サマーダイブ2011 極楽門からこんにちは',
      :startdate   => Date.new(2011, 8, 20),
      :image       => 'http://www.momoclo.net/discography/img/gokurakumon_dvd.jpg',
      :description => 'よみうりランド',
      :importance  => 40,
    }, {
      :id          => 4,
      :name        => 'ももクロ女祭り2011',
      :startdate   => Date.new(2011, 10, 30),
      :image       => 'http://www.momoclo.net/discography/img/onnafes2011_dvd.jpg',
      :description => 'Shibuya O-EAST',
      :importance  => 40,
    }, {
      :id          => 5,
      :name        => 'ももクロ男祭り2011',
      :startdate   => Date.new(2011, 11, 6),
      :image       => 'http://www.momoclo.net/discography/img/otokofes2011_dvd.jpg',
      :description => '品川ステラボール',
      :importance  => 40,
    }, {
      :id          => 6,
      :name        => 'ももいろクリスマス2011 さいたまスーパーアリーナ大会',
      :startdate   => Date.new(2011, 12, 25),
      :image       => 'http://www.momoclo.net/discography/img/momokuri2011_bd.jpg',
      :description => 'さいたまスーパーアリーナ',
      :importance  => 40,
    }, {
      :id          => 7,
      :name        => 'ももクロ春の一大事２０１２　横浜アリーナまさかの２DAYS - ももクロ☆オールスターズ 2012 - ',
      :startdate   => Date.new(2012, 4, 21),
      :image       => 'http://www.momoclo.net/schedule/img/yokohama2days_logo.jpg',
      :description => '横浜アリーナ',
      :importance  => 40,
    }, {
      :id          => 8,
      :name        => 'ももクロ春の一大事２０１２　横浜アリーナまさかの２DAYS - 見渡せば大パノラマ地獄 - ',
      :startdate   => Date.new(2012, 4, 22),
      :image       => 'http://www.momoclo.net/schedule/img/yokohama2days_logo.jpg',
      :description => '横浜アリーナ',
      :importance  => 40,
    }, {
      :id          => 9,
      :name        => 'ももクロの子供祭りだョ！全員集合',
      :startdate   => Date.new(2012, 5, 5),
      :image       => 'http://www.momoclo.net/schedule/img/kodomomatsuri_logo.jpg',
      :description => '戸田市文化会館',
      :importance  => 40,
    }, {
      :id         => 101,
      :name       => 'シングル『ももいろパンチ』発売',
      :startdate  => Date.new(2009, 8, 5),
      :image      => 'http://www.momoclo.net/discography/img/momopan_regular.jpg',
      :importance => 35,
    }, {
      :id         => 102,
      :name       => 'シングル『未来へススメ！』発売',
      :startdate  => Date.new(2009, 11, 11),
      :image      => 'http://www.momoclo.net/discography/img/mirai_regular.jpg',
      :importance => 35,
    }, {
      :id         => 103,
      :name       => 'シングル『行くぜっ！怪盗少女』発売',
      :startdate  => Date.new(2010, 5, 5),
      :image      => 'http://www.momoclo.net/discography/img/kaito_all.jpg',
      :importance => 35,
    }, {
      :id         => 104,
      :name       => 'シングル『ピンキージョーンズ』発売',
      :startdate  => Date.new(2010, 11, 10),
      :image      => 'http://www.momoclo.net/discography/img/pj_regular.jpg',
      :importance => 35,
    }, {
      :id         => 105,
      :name       => 'シングル『ミライボウル／Chai Maxx』発売',
      :startdate  => Date.new(2011, 3, 9),
      :image      => 'http://www.momoclo.net/discography/img/miraiball_regular.jpg',
      :importance => 35,
    }, {
      :id         => 106,
      :name       => 'シングル『Z伝説～終わりなき革命～』発売',
      :startdate  => Date.new(2011, 7, 6),
      :image      => 'http://www.momoclo.net/discography/img/zdensetsu.jpg',
      :importance => 35,
    }, {
      :id         => 107,
      :name       => "シングル『D'の純情』発売",
      :startdate  => Date.new(2011, 7, 6),
      :image      => 'http://www.momoclo.net/discography/img/dnojyunjyo.jpg',
      :importance => 35,
    }, {
      :id         => 108,
      :name       => 'シングル『労働讃歌』発売',
      :startdate  => Date.new(2011, 11, 23),
      :image      => 'http://www.momoclo.net/discography/img/roudou_C.jpg',
      :importance => 35,
    }, {
      :id         => 109,
      :name       => 'シングル『猛烈宇宙交響曲・第七楽章「無限の愛」』発売',
      :startdate  => Date.new(2012, 3, 7),
      :image      => 'http://www.momoclo.net/discography/img/mugennoai_tujyo.jpg',
      :importance => 35,
    }, {
      :id         => 201,
      :name       => 'アルバム『バトル アンド ロマンス』発売',
      :startdate  => Date.new(2011, 7, 27),
      :image      => 'http://www.momoclo.net/discography/img/1stal_regular.jpg',
      :importance => 35,
    }
  ])

db[:episode_types].delete
db[:episode_types].insert_multiple([{
      :id    => 0,
      :name  => 'その他',
    }, {
      :id    => 1,
      :name  => 'ライブ/イベントでの思い出',
    }, {
      :id    => 2,
      :name  => 'ももクロとの出会い',
    }
  ])
puts 'done'
