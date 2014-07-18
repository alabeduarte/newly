require 'nokogiri'
require 'open-uri'

module Newly
  class Selector

    def initialize(feed, selector=Nokogiri::HTML(open feed.url))
      @feed, @selector = feed, selector
    end

    def all
      @selector.css(@feed.selector).first(@feed.limit)
    end

    def title
      @selector.at_css("title").text
    end

  end
end