require 'sequel'

Sequel.connect(ENV['SHARED_DATABASE_URL'])

class OfficialEvent < Sequel::Model
  plugin :json_serializer
end
