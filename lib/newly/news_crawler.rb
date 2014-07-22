require 'set'
require 'newly/selector'
require 'newly/page_crawler'
require 'newly/news'

module Newly
  class NewsCrawler
    attr_reader :title, :selector, :url

    def initialize(args)
      @feed = args[:feed]
      @url = args[:url]
      raise "The url is required" unless @url

      @selector = args[:selector] || Newly::Selector.new(Nokogiri::HTML(open @url))
    end

    def fetch
      news_fetched = Set.new
      all_news = @selector.all(container: @feed.container, max: @feed.limit)

      all_news.each do |item|
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
        page_crawler = Newly::PageCrawler.new(@feed.host, item)

        Newly::News.new(page_crawler: page_crawler, feed: @feed, feed_url: @url)
      end
    end

  end
end