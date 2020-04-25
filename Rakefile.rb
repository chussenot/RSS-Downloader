require File.expand_path('feed_entry', __dir__)
require 'active_record'
require 'fileutils'

namespace :db do # rubocop:todo Metrics/BlockLength
  desc 'migrate your database'
  task :migrate do
    ActiveRecord::Migrator.migrate(
      'db/migrate',
      ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    )
  end

  desc 'create an ActiveRecord migration in ./db/migrate'
  task :create_migration do
    name = ENV['NAME']
    unless name
      abort('no NAME specified. use `rake db:create_migration NAME=create_users`')
    end

    migrations_dir = File.join('db', 'migrate')
    version = ENV['VERSION'] || Time.now.utc.strftime('%Y%m%d%H%M%S')
    filename = "#{version}_#{name}.rb"
    migration_name = name.gsub(/_(.)/) { Regexp.last_match(1).upcase }.gsub(/^(.)/) { Regexp.last_match(1).upcase }

    FileUtils.mkdir_p(migrations_dir)

    open(File.join(migrations_dir, filename), 'w') do |f|
      # rubocop:todo Naming/HeredocDelimiterNaming
      f << <<-EOS.gsub('      ', '')
      # rubocop:enable Naming/HeredocDelimiterNaming
      class #{migration_name} < ActiveRecord::Migration
        def self.up
        end

        def self.down
        end
      end
      EOS
    end
  end
end
