require 'nokogiri'
require 'open-uri'
require 'news'

class Newly
  
  attr_reader :title, :selector, :url
  
  def initialize(url, html_file=nil)
    @url = url
    if (html_file)
      @selector = Nokogiri::HTML.parse(File.read(html_file))
    else
      @selector = Nokogiri::HTML(open(url))
    end
    @title = @selector.at_css("title").text
  end
  
  def fetch(args)
    array = Array.new
    @selector.css(args[:css]).each do |item|
      if (item)
        if (args[:property].nil?)
          array << item.css(args[:tag]).text
        else
          array << item.css(args[:tag]).map { |doc| doc[args[:property]] }.first
        end
      end
    end
    array
  end
  
  def highlights(args)
    news = Array.new
    @selector.css(args[:css]).each do |item|
      if (item)
        url = item.css(args[:url]).map { |doc| doc['href'] }.first if args[:url]
        
        # doc = Nokogiri::HTML(open(url))
        # keywords = doc.xpath("//meta[@name='Keywords']/@content") if doc
        keywords = nil
        
        date = item.css(args[:date]).text if args[:date]
        title = item.css(args[:title]).text if args[:title]
        subtitle = item.css(args[:subtitle]).text if args[:subtitle]
        image = item.css(args[:image]).map { |doc| doc['src'] }.first if args[:image]
        if (args[:host])
          host = args[:host]
          url = "#{host}/#{url}".gsub('../', '') if url
          image = "#{host}/#{image}".gsub('../', '') if image && image.include?('../')
        end
        news << News.new(url: url, keywords: keywords, date: date, title: title, subtitle: subtitle, image: image)
      end
    end
    news
  end
  
end
