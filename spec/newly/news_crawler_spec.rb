require 'spec_helper'

describe Newly::NewsCrawler do

  let(:html) { 'spec/html/page_spec.html' }

  describe "fetching news" do

    it "should fetch news with limit" do
      first_feed_with_limit = Newly::Feed.new(url: 'http://bla.x', container: ".chamada-principal", limit: 2, selector: parse(html))
      first_reader = build_reader_with first_feed_with_limit

      expect(first_reader).to have(2).fetch
    end

    it "should fetch news without limit" do
      first_feed_without_limit = Newly::Feed.new(
        url: 'http://bla.x',
        container: ".chamada-principal",
        url_pattern: "a",
        title: ".conteudo p",
        image_source: "img",
        selector: parse(html))
      first_reader = build_reader_with first_feed_without_limit

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
            image_source: "img",
            selector: parse(html))
        end
        let(:first_reader) { build_reader_with first_feed }

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
            url: "http://noticias.uol.com.br/noticias",
            container: "div.geral section article.news",
            url_pattern: "h1 a",
            title: "h1 a span",
            subtitle: "p",
            selector: parse(html))
        end
        let(:second_reader) { build_reader_with second_feed }

        context "fetching news valid fields" do
          let(:a_news) { second_reader.fetch.first }

          it { expect(a_news.url).to eq 'http://esporte.uol.com.br/ultimas-noticias/reuters/2012/09/08/jackie-stewart-aconselha-hamilton-a-continuar-na-mclaren.htm' }
          it { expect(a_news.title).to eq 'Jackie Stewart aconselha Hamilton a continuar na McLaren' }
          it { expect(a_news.subtitle).to eq 'MONZA, 8 Set (Reuters) - Tricampeao de Formula 1, Jackie Stewart aconselhou Lewis Hamilton neste sabado a...' }
          it { expect(a_news.feed_url).to eq "http://noticias.uol.com.br/noticias" }
        end
      end

      context "when reader is invalid" do
        it "should not return news from invalid reader" do
          invalid_feed = Newly::Feed.new(container: "invalid", selector: parse(html))
          invalid_reader = build_reader_with invalid_feed

          expect(invalid_reader).to have(0).fetch
        end

        context "should not return value from invalid field" do
          let(:invalid_feed) do
            Newly::Feed.new(
              url: "http://noticias.uol.com.br/noticias",
              container: "div.geral section article.news",
              url_pattern: "x",
              title: "x",
              subtitle: "x",
              selector: parse(html))
          end
          let(:invalid_reader) { build_reader_with invalid_feed }
          let(:a_news) { invalid_reader.fetch.first }

          it { expect(a_news.url).to be_nil }
          it { expect(a_news.title).to be_nil }
          it { expect(a_news.subtitle).to be_nil }
        end
      end

    end

  end

private
  def build_reader_with(feed)
    Newly::NewsCrawler.new(feed)
  end
  def parse(path)
    Newly::Selector.new Nokogiri::HTML.parse(File.read path)
  end
end
