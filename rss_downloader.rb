require 'feedjira'
require 'whenever'
require File.expand_path('feed_entry', __dir__)

feed_url = ENV['FEED_URL']

FeedEntry.update_from_feed(feed_url)