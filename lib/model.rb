require 'sequel'

Sequel.connect(ENV['SHARED_DATABASE_URL'])

class Event < Sequel::Model
end

class EpisodeType < Sequel::Model
end

class User < Sequel::Model
  one_to_many :episodes
  self.unrestrict_primary_key
  plugin :validation_helpers

  def validate
    validates_presence [:id]
  end

  def before_create
    self.created_at ||= Time.now
    super
  end
end

class Episode < Sequel::Model
  many_to_one :user
  self.strict_param_setting      = false
  self.raise_on_typecast_failure = false
  plugin :validation_helpers

  def validate
    validates_presence [:type, :text, :startdate]
    validates_integer [:type]
    validates_max_length 400, :text
  end

  def before_create
    self.created_at ||= Time.now
    super
  end
end
