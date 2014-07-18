module Newly
  class Selector
    def initialize(selector)
      @selector = selector
    end

    def all(args)
      args[:max] ?
        @selector.css(args[:container]).first(args[:max]) :
        @selector.css(args[:container])
    end

    def title
      @selector.at_css("title").text
    end
  end
end