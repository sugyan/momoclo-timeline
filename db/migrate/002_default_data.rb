# -*- coding: utf-8 -*-

Sequel.migration do
  up do
    self[:official_events].insert_multiple([{
          :name => 'ももいろクリスマス in 日本青年館 ~脱皮:DAPPI~',
          :date => Date.new(2010, 12, 24),
          :place => '日本青年館',
        }, {
          :name => '4.10中野サンプラザ大会 ももクロ春の一大事 ~眩しさの中に君がいた~',
          :date => Date.new(2011, 4, 10),
          :place => '中野サンプラザ',
        }, {
          :name => 'サマーダイブ2011 極楽門からこんにちは',
          :date => Date.new(2011, 8, 20),
          :place => 'よみうりランド',
        }, {
          :name => 'ももクロ女祭り2011',
          :date => Date.new(2011, 10, 30),
          :place => 'Shibuya O-EAST',
        }, {
          :name => 'ももクロ男祭り2011',
          :date => Date.new(2011, 11, 6),
          :place => '品川ステラボール',
        }, {
          :name => '「ももいろクリスマス2011 さいたまスーパーアリーナ大会」',
          :date => Date.new(2011, 12, 25),
          :place => 'さいたまスーパーアリーナ',
        }, {
          :name => '「ももクロ春の一大事２０１２　横浜アリーナまさかの２DAYS」 - ももクロ☆オールスターズ 2012 - ',
          :date => Date.new(2012, 4, 21),
          :place => '横浜アリーナ',
        }, { 
          :name => '「ももクロ春の一大事２０１２　横浜アリーナまさかの２DAYS」 - 見渡せば大パノラマ地獄 - ',
          :date => Date.new(2012, 4, 22),
          :place => '横浜アリーナ',
        }
    ])
  end
  
  down do
    self[:official_events].delete
  end
end
