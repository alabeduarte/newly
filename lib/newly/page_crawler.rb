module Newly
  class PageCrawler
    def initialize(host, document)
      @host = host
      @document = document
    end

    def titleize(element)
      title = text(element)
      title[0] = title.capitalize[0] if title

      title
    end

    def text(element)
      if valid?(element)
        text = get(element).text
        text if valid?(text)
      end
    end

    def link(element)
      href = find(element, 'href')
      href = "#{@host}/#{href}".gsub('../', '') if href && !href.include?('http')
      href
    end

    def image(element)
      image = find(element, 'src')
      if (image && image.include?("==/"))
        image = "http://#{image.split("==/").last}"
      end
      image = "#{@host}/#{image}".gsub('../', '') if image && image.include?('../')
      image
    end

  private
    def valid?(str)
      str && !str.empty?
    end

    def get(element)
      @document.css(element)
    end

    def find(element, type)
      get(element).map { |doc| doc[type] }.first if valid?(element)
    end

  end
end