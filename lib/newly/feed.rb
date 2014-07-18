require 'nokogiri'
require 'open-uri'

module Newly
  class Feed
    attr_reader :container, :url_pattern, :title, :subtitle, :image_source, :favicon, :host, :limit

    def initialize(args)
      @container = args[:container]
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