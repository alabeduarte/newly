module Newly
  class News
    attr_reader :url, :url_pattern, :title, :subtitle, :image, :feed_url

    def initialize(args)
      page_crawler = args[:page_crawler]
      feed = args[:feed]

      @url = page_crawler.link feed.url_pattern
      @title = page_crawler.titleize feed.title
      @subtitle = page_crawler.titleize feed.subtitle
      @image = page_crawler.image feed.image_source
      @feed_url = feed.url
    end
  end
end