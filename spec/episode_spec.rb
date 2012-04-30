# -*- coding: utf-8 -*-
require_relative '../lib/model'

describe Episode do
  describe 'validate' do
    it 'empty' do
      e = Episode.new
      e.valid?.should be false
    end

    it 'success' do
      params = {
        :type      => 1,
        :text      => 'ほげふがぴよ',
        :startdate => Date.today(),
      }
      e = Episode.new(params)
      e.valid?.should be true
      e.errors.should be_empty
    end

    describe 'save' do
      before do
        Episode.delete
        User.delete
        User.create({
            :id          => 1,
            :screen_name => 'sugyan',
            :name        => 'すぎゃーん',
            :image       => 'http://example.com/icon.png',
            :description => 'いま会えるネットアイドル ももいろすぎゃーんＺ',
          })
      end

      it 'auto created_at' do
        params = {
          :type      => 1,
          :text      => 'ほげふがぴよ',
          :startdate => Date.today(),
        }
        e = User[1].add_episode(params)
        e.created_at.should be_true
      end

      after do
        Episode.delete
        User.delete
      end
    end

    it 'invalid type' do
      params = {
        :type      => 1,
        :text      => 'ほげふがぴよ',
        :startdate => Date.today(),
      }
      e1 = Episode.new(params)
      e1.valid?.should be true
      e1.errors.should be_empty

      params[:type] = ''
      e2 = Episode.new(params)
      e2.valid?.should be false
      e2.errors.should have_key(:type)

      params[:type] = 'abc'
      e3 = Episode.new(params)
      e3.valid?.should be false
      e3.errors.should have_key(:type)

      params.delete(:type)
      e4 = Episode.new(params)
      e4.valid?.should be false
      e4.errors.should have_key(:type)
    end

    it 'invalid text' do
      params = {
        :type      => 1,
        :text      => 'ほげふがぴよ',
        :startdate => Date.today(),
      }
      e1 = Episode.new(params)
      e1.valid?.should be true
      e1.errors.should be_empty

      params[:text] = ''
      e2 = Episode.new(params)
      e2.valid?.should be false
      e2.errors.should have_key(:text)

      params[:text] = 'ほげふが' * 100
      e3 = Episode.new(params)
      e3.valid?.should be true
      e3.errors.should be_empty

      params[:text] = 'ほげふが' * 100 + 'ぴ'
      e4 = Episode.new(params)
      e4.valid?.should be false
      e4.errors.should have_key(:text)

      params.delete(:text)
      e5 = Episode.new(params)
      e5.valid?.should be false
      e5.errors.should have_key(:text)
    end
  end
end
