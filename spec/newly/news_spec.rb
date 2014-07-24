require 'spec_helper'

describe Newly::News do
  describe "exposing attributes" do
    it "should expose attribute values as hash" do
      news = build_reader.fetch.first

      expect(news.to_hash).to eq({
        url:      'http://esporte.uol.com.br/ultimas-noticias/reuters/2012/09/08/jackie-stewart-aconselha-hamilton-a-continuar-na-mclaren.htm',
        title:    'Jackie Stewart aconselha Hamilton a continuar na McLaren',
        subtitle: 'MONZA, 8 Set (Reuters) - Tricampeao de Formula 1, Jackie Stewart aconselhou Lewis Hamilton neste sabado a...',
        feed_url: 'http://noticias.uol.com.br/noticias',
        image:    'http://s.glbimg.com/en/ho/f/original/2012/09/29/exobeso.jpg',
      })
    end
  end

  private
  def build_reader
    url = 'http://noticias.uol.com.br/noticias'
    feed = Newly::Feed.new(
            container:    'div.geral section article.news',
            url_pattern:  'h1 a',
            title:        'h1 a span',
            subtitle:     'p',
            image_source: 'img'
            )

    Newly::NewsCrawler.new(selector: fake_selector, url: url, feed: feed)
  end
  def fake_selector
    parsed_html = Nokogiri::HTML.parse(File.read 'spec/html/page_spec.html')
    Newly::Selector.new parsed_html
  end
end