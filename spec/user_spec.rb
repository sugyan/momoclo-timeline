# -*- coding: utf-8 -*-
require_relative '../lib/model'

describe User do
  describe 'validate' do
    it 'empty' do
      u = User.new
      u.valid?.should be false
    end

    it 'success' do
      params = {
        :id          => 1,
        :screen_name => 'sugyan',
        :name        => 'すぎゃーん',
        :image       => 'http://example.com/icon.png',
        :description => 'いま会えるネットアイドル ももいろすぎゃーんＺ',
      }
      u = User.new(params)
      u.valid?.should be true
    end

    describe 'save' do
      before do
        User.delete
      end

      it 'auto created_at' do
        params = {
          :id          => 1,
          :screen_name => 'sugyan',
          :name        => 'すぎゃーん',
          :image       => 'http://example.com/icon.png',
          :description => 'いま会えるネットアイドル ももいろすぎゃーんＺ',
        }
        u = User.create(params)
        u.created_at.should be_true
      end

      it 'update' do
        params = {
          :id          => 1,
          :screen_name => 'sugyan',
          :name        => 'すぎゃーん',
          :image       => 'http://example.com/icon.png',
          :description => 'いま会えるネットアイドル ももいろすぎゃーんＺ',
        }
        u1 = User.new(params)
        u1.valid?.should be true
        u1.save
        User[1].should be_true
        # duplicate key
        params[:name] = 'すぎゃーんＺ'
        u2 = User.new(params)
        u2.valid?.should be true
        expect {
          u2.save
        }.to raise_error(Sequel::DatabaseError)
        # update
        User[1].update(params)
        User[1].name.should eq('すぎゃーんＺ')
      end

      after do
        User.delete
      end
    end
  end
end
