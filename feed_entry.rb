require 'bundler/setup'
require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'httparty'
require 'pry'

class FeedEntry < ActiveRecord::Base # rubocop:todo Style/Documentation
  def self.update_from_feed(feed_url)
    xml = HTTParty.get(feed_url).body
    feed = Feedjira.parse(xml)
    add_entries(feed.entries)
  end

  def self.database_options
    options = {
      adapter: 'sqlite3',
      database: 'db/epub.db'
    }
  end

  private
  def self.add_entries(entries) # rubocop:todo Lint/IneffectiveAccessModifier
    entries.each do |entry|
      # Example entry for sqlite db. Change if need be.
      next if exists? guid: entry.id
      create!(
        name: entry.title,
        summary: entry.summary,
        url: entry.url,
        image: entry.image,
        author: entry.author,
        guid: entry.id
      )
      binding.pry
      system(%(open -a PATH_TO_APPLICATION '#{entry.url}'))
    end
  end
  # rubocop:enable Metrics/MethodLength
end

ActiveRecord::Base.establish_connection(FeedEntry.database_options)