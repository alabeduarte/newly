module Newly
  class Feed
    attr_reader :url, :selector, :url_pattern, :title, :subtitle, :image_source, :favicon, :host, :limit

    def initialize(args)
      @url = args[:url]
      @selector = args[:selector]
      @url_pattern = args[:url_pattern]
      @title = args[:title]
      @subtitle = args[:subtitle]
      @image_source = args[:image_source]
      @favicon = args[:favicon]
      @host = args[:host]
      @limit = args[:limit]
    end
  end
end