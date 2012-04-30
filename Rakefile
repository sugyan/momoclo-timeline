require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

namespace :db do
    require 'sequel'
    Sequel.extension :migration

    task :migrate do
        db = Sequel.connect(ENV['SHARED_DATABASE_URL'])
        dir = 'db/migrate'
        target = ENV['TARGET'] ? ENV['TARGET'].to_i : nil
        Sequel::Migrator.run(db, dir, :target => target)
    end
end
