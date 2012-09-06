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
        href = find_link(item, args[:href], 'href')
        date = find(item, args[:date])
        title = find(item, args[:title])
        subtitle = find(item, args[:subtitle])
        img = find_link(item, args[:img], 'src')
        host = args[:host]
        if host
          href = "#{host}/#{href}".gsub('../', '') if href && !href.include?('http')
          image = "#{host}/#{image}".gsub('../', '') if image && image.include?('../')
        end
        news << News.new(url: href, date: date, title: title, subtitle: subtitle, image: img)
      end
    end
    news
  end

private
  def find_link(item, element, src)
    item.css(element).map { |doc| doc[src] }.first if valid?(element)
  end

  def find(item, element)
    item.css(element).text if valid?(element)
  end

  def valid?(element)
    element && !element.empty?
  end
end
