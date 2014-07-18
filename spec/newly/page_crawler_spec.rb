require 'spec_helper'
describe Newly::PageCrawler do
  let(:selector) { Nokogiri::HTML }
  let(:host) { 'http://atualidadesweb.com.br' }
  let(:subject) { Newly::PageCrawler.new(host, parse('spec/html/page_spec.html')) }

  describe "#text" do
    context "when is valid input" do
      it { expect(subject.text(".a")).to eq "I'm a Example Page" }
      it { expect(subject.text(".b")).to eq "I'm a another Example Page" }
    end
    context "when is invalid input" do
      it { expect(subject.text(".c")).to be_nil }
      it { expect(subject.text("")).to be_nil }
      it { expect(subject.text(nil)).to be_nil }
    end
  end

  describe "#link" do
    context "when is valid input" do
      it { expect(subject.link(".a")).to eq "#{host}" }
      it { expect(subject.link(".b")).to eq "#{host}/sports" }
      it { expect(subject.link(".c")).to eq "#{host}/economy" }
      it { expect(subject.link(".d")).to eq "#{host}//economy" }
      it { expect(subject.link(".e")).to eq "#{host}/economy" }
    end
    context "when is invalid input" do
      it { expect(subject.link(".absent")).to be_nil }
      it { expect(subject.link("")).to be_nil }
      it { expect(subject.link(nil)).to be_nil }
    end
  end

  describe "#image" do
    context "when is valid input" do
      it { expect(subject.image("img.a-img")).to eq "#{host}/images/logo.png" }
      it { expect(subject.image("img.b-img")).to eq "#{host}/images/logo2.png" }
      it { expect(subject.image("img.d-img")).to eq "#{host}/images/logo3.png" }
      it { expect(subject.image("img.c-img")).to eq "#{host}/images/logo4.png" }
      it { expect(subject.image("img.e-img")).to eq "#{host}/images/logo5.png" }
    end
    context "when is invalid input" do
      it { expect(subject.image("img.absent")).to be_nil }
      it { expect(subject.image("")).to be_nil }
      it { expect(subject.image(nil)).to be_nil }
    end
  end

  def parse(path)
    selector.parse(File.read(path))
  end
end
