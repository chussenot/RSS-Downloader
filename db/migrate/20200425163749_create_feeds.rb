# rubocop:enable Naming/HeredocDelimiterNaming
class CreateFeeds < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define do
      create_table :feed_entries do |table|
          table.column :name, :string
          table.column :summary, :string
          table.column :url, :string
          table.column :image, :string
          table.column :author, :string
      end
    end
  end

  def self.down
  end
end
