module Newly
  class News
    attr_reader :url, :title, :subtitle, :image, :feed_url

    def initialize(args)
      page_crawler = args[:page_crawler]
      feed = args[:feed]

      @feed_url = args[:feed_url]
      @url = page_crawler.link feed.url_pattern
      @title = page_crawler.titleize feed.title
      @subtitle = page_crawler.titleize feed.subtitle
      @image = page_crawler.image feed.image_source
    end

    def to_hash
      {
        url: @url,
        title: @title,
        subtitle: @subtitle,
        image: @image,
        feed_url: @feed_url
      }
    end
  end
end