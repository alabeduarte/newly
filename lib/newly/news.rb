module Newly
  class News

    attr_reader :url, :url_pattern, :title, :subtitle, :image, :featured_level, :feed

    def initialize(args)
      @url = args[:url]
      @title = args[:title]
      @subtitle = args[:subtitle]
      @image = args[:image]
      @featured_level = args[:featured_level]
      @feed = args[:feed]
    end

    private
    def self.valid?(options)
      options[:title] || options[:subtitle]
    end

  end
end