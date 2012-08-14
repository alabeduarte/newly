require 'nokogiri'
require 'open-uri'
require 'news'

class Newly
  
  attr_reader :title, :selector, :url
  
  def initialize(url, selector=Nokogiri::HTML(open(url)))
    @url = url
    @selector = selector
    @title = @selector.at_css("title").text
  end
  
  def highlights(args)
    news = Array.new
    @selector.css(args[:selector]).each do |item|
      if (item)
        href = item.css(args[:href]).map { |doc| doc['href'] }.first if args[:href]
        
        # doc = Nokogiri::HTML(open(url))
        # keywords = doc.xpath("//meta[@name='Keywords']/@content") if doc
        keywords = nil
        
        date = item.css(args[:date]).text if args[:date]
        title = item.css(args[:title]).text if args[:title]
        subtitle = item.css(args[:subtitle]).text if args[:subtitle]
        img = item.css(args[:img]).map { |doc| doc['src'] }.first if args[:img]
        if (args[:host])
          host = args[:host]
          url = "#{host}/#{url}".gsub('../', '') if url
          image = "#{host}/#{image}".gsub('../', '') if image && image.include?('../')
        end
        news << News.new(url: href, keywords: keywords, date: date, title: title, subtitle: subtitle, image: img)
      end
    end
    news
  end
end
