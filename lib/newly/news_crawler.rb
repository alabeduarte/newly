module Newly
  class NewsCrawler

    attr_reader :title, :selector, :url

    def initialize(feed, selector)
      @feed = feed
      @selector = selector
    end

    def fetch
      news_fetched = Set.new
      @selector.all.each do |item|
        news_fetched << build_news_by(item)
      end

      news_fetched.to_a
    end

  private
    def build_news_by(item)
      if (item)
        page_crawler = PageCrawler.new(@feed.host, item)
        Newly::News.new(
          url: page_crawler.link(@feed.url_pattern),
          featured_level: @feed.featured_level,
          title: page_crawler.titleize(@feed.title),
          subtitle: page_crawler.titleize(@feed.subtitle),
          image: page_crawler.image(@feed.image_source),
          feed: @feed
        )
      end
    end

  end
end