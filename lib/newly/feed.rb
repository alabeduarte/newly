module Newly
  class Feed

    attr_reader :url, :selector, :url_pattern, :title, :subtitle, :image_source, :favicon, :host, :featured_level, :limit

    def initialize(args)
      @url = args[:url]
      @selector = args[:selector]
      @url_pattern = args[:url_pattern]
      @title = args[:title]
      @subtitle = args[:subtitle]
      @image_source = args[:image_source]
      @favicon = args[:favicon]
      @host = args[:host]
      @featured_level = args[:featured_level]
      @limit = args[:limit]
    end

    # validates :selector, :url_pattern, :presence => true
    # validates :url, :host, :format => URI::regexp(%w(http https)), :presence => true
    # validates :featured_level, :limit, :numericality => true, :presence => true

  end
end