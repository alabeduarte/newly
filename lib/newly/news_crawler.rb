module Newly
  class NewsCrawler

    attr_reader :title, :selector, :url

    def initialize(selector)
      @selector = selector
    end

    def fetch
      news_fetched = Set.new
      @selector.all.each do |item|
        news = build_news_by(item)
        if news
          news_fetched << news
        end
      end

      news_fetched.to_a
    end

  private
    def build_news_by(item)
      if (item)
        feed = selector.feed
        page_crawler = PageCrawler.new(feed.host, item)

        Newly::News.new(page_crawler: page_crawler, feed: feed)
      end
    end

  end
end