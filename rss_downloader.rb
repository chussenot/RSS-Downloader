require 'feedjira'
require 'whenever'
require File.expand_path('feed_entry', __dir__)

feed_url = 'http://xfmro77i3lixucja.onion.sh/search/?q=tag:computer&p=1&num=20&fmt=rss'

FeedEntry.update_from_feed(feed_url)