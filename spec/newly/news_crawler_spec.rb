require 'spec_helper'

describe Newly::NewsCrawler do

  describe "fetching news" do

    it "should fetch news with limit" do
      first_feed_with_limit = Newly::Feed.new(url: 'http://bla.x', container: ".chamada-principal", limit: 2)
      first_reader = build_reader_with 'http://bla.x', first_feed_with_limit

      expect(first_reader).to have(2).fetch
    end

    it "should fetch news without limit" do
      first_feed_without_limit = Newly::Feed.new(
        url: 'http://bla.x',
        container: ".chamada-principal",
        url_pattern: "a",
        title: ".conteudo p",
        image_source: "img"
        )
      first_reader = build_reader_with 'http://bla.x', first_feed_without_limit

      expect(first_reader).to have(4).fetch
    end

    describe "when news has content" do
      context "first feed" do
        let(:first_feed) do
          Newly::Feed.new(
            url: 'http://bla.x',
            container: ".chamada-principal",
            url_pattern: "a",
            title: ".conteudo p",
            image_source: "img"
            )
        end
        let(:first_reader) { build_reader_with 'http://bla.x', first_feed }

        it "should fetch high quality images" do
          a_news = first_reader.fetch.first
          expect(a_news.image).to eq "http://s.glbimg.com/en/ho/f/original/2012/09/29/exobeso.jpg"
        end
        it "should capitalize the title field" do
          a_news = first_reader.fetch.first
          expect(a_news.title).to eq "Fenomeno assustador"
        end
      end

      context "second feed" do
        let(:second_feed) do
          Newly::Feed.new(
            container: "div.geral section article.news",
            url_pattern: "h1 a",
            title: "h1 a span",
            subtitle: "p"
            )
        end
        let(:second_reader) { build_reader_with 'http://noticias.uol.com.br/noticias', second_feed }

        context "fetching news valid fields" do
          let(:a_news) { second_reader.fetch.first }

          it { expect(a_news.url).to eq 'http://esporte.uol.com.br/ultimas-noticias/reuters/2012/09/08/jackie-stewart-aconselha-hamilton-a-continuar-na-mclaren.htm' }
          it { expect(a_news.title).to eq 'Jackie Stewart aconselha Hamilton a continuar na McLaren' }
          it { expect(a_news.subtitle).to eq 'MONZA, 8 Set (Reuters) - Tricampeao de Formula 1, Jackie Stewart aconselhou Lewis Hamilton neste sabado a...' }
          it { expect(a_news.feed_url).to eq "http://noticias.uol.com.br/noticias" }
        end
      end

      context "when reader has some invalid field" do
        it "should not return news from invalid container" do
          invalid_feed = Newly::Feed.new(
            url: "http://bla.x",
            container: "invalid"
            )
          invalid_reader = build_reader_with 'http://bla.x', invalid_feed

          expect(invalid_reader).to have(0).fetch
        end

        it "should not allow build readers without url" do
          invalid_feed = Newly::Feed.new(container: "div.geral section article.news")

          expect { Newly::NewsCrawler.new(fake_selector, nil, invalid_feed) }.to raise_error "The url is required"
        end
      end

    end

  end

private
  def build_reader_with(url, feed)
    Newly::NewsCrawler.new(fake_selector, url, feed)
  end
  def fake_selector
    parsed_html = Nokogiri::HTML.parse(File.read 'spec/html/page_spec.html')
    Newly::Selector.new parsed_html
  end
end
