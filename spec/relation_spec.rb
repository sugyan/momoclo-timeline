# -*- coding: utf-8 -*-
require_relative '../lib/model'

describe 'episode-user' do
  before do
    Episode.delete
    User.delete
    u = User.create({
        :id          => 1,
        :screen_name => 'sugyan',
        :name        => 'すぎゃーん',
        :image       => '',
      })
    u.add_episode({
        :type      => 0,
        :text      => 'ほげ',
        :startdate => Date.today(),
      })
    u.add_episode({
        :type      => 0,
        :text      => 'ふが',
        :startdate => Date.today(),
      })
  end

  it 'many_to_one, one_to_many' do
    Episode.count.should eq(2)
    Episode.each do |e|
      e.user.should be_an_instance_of(User)
    end
  end

  it 'join' do
    Episode.join(:users, :id => :user_id).each do |row|
      row[:screen_name].should eq('sugyan')
    end

    hashes = Episode.join(:users, :id => :user_id).map do |row|
      row.values
    end
    hashes.length.should eq(2)
  end

  after do
    Episode.delete
    User.delete
  end
end
