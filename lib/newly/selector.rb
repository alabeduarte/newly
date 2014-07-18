require 'nokogiri'
require 'open-uri'

module Newly
  class Selector
    attr_reader :feed

    def initialize(feed, selector=Nokogiri::HTML(open feed.url))
      @feed, @selector = feed, selector
    end

    def all
      @feed.limit ?
        @selector.css(@feed.selector).first(@feed.limit) :
        @selector.css(@feed.selector)
    end

    def title
      @selector.at_css("title").text
    end

  end
end