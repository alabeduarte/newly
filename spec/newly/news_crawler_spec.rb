require 'spec_helper'

describe Newly::NewsCrawler do

  feeds = {
    first_feed: Newly::Feed.new(
      selector: ".chamada-principal",
      url_pattern: "a",
      title: ".conteudo p",
      image_source: "img",
      limit: 3),

    second_feed: Newly::Feed.new(
      selector: "div.geral section article.news",
      url_pattern: "h1 a",
      title: "h1 a span",
      subtitle: "p",
      limit: 3)
  }

  let(:first_feed) { feeds[:first_feed] }
  let(:second_feed) { feeds[:second_feed] }

  let(:first_reader) { build_reader_with(first_feed, 'spec/html/page_spec.html') }
  let(:second_reader) { build_reader_with(second_feed, 'spec/html/page_spec.html') }

  describe "fetching news" do

    it "should fetch news with limit" do
      first_reader.should have(3).fetch
    end

    context "when news has content" do
      let(:a_news) { second_reader.fetch.first }
      it { a_news.url.should == 'http://esporte.uol.com.br/ultimas-noticias/reuters/2012/09/08/jackie-stewart-aconselha-hamilton-a-continuar-na-mclaren.htm' }
      it { a_news.title.should == 'Jackie Stewart aconselha Hamilton a continuar na McLaren' }
      it { a_news.subtitle.should == 'MONZA, 8 Set (Reuters) - Tricampeao de Formula 1, Jackie Stewart aconselhou Lewis Hamilton neste sabado a...' }
      it { a_news.feed.url == "http://noticias.uol.com.br/noticias" }
    end

    context "http://globo.com" do
      context "validating 'http://www.globo.com' selector" do
        it "should fetch high quality images" do
          a_news = first_reader.fetch.first
          a_news.image.should == "http://s.glbimg.com/en/ho/f/original/2012/09/29/exobeso.jpg"
        end
        it "should capitalize the title field" do
          a_news = first_reader.fetch.first
          a_news.title.should == "Fenomeno assustador"
        end
      end
    end

  end

private
  def build_reader_with(feed, html)
    selector = Newly::Selector.new(feed, parse(html))
    Newly::NewsCrawler.new(feed, selector)
  end
  def parse(path)
    Nokogiri::HTML.parse(File.read(path))
  end
end
