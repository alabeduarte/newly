require 'spec_helper'
describe Newly::PageCrawler do
  let(:selector) { Nokogiri::HTML }
  let(:host) { 'http://atualidadesweb.com.br' }
  let(:subject) { Newly::PageCrawler.new(host, parse('spec/html/page_spec.html')) }

  describe "#text" do
    context "when is valid input" do
      it { subject.text(".a").should == "I'm a Example Page" }
      it { subject.text(".b").should == "I'm a another Example Page" }
    end
    context "when is invalid input" do
      it { subject.text(".c").should be_nil }
      it { subject.text("").should be_nil }
      it { subject.text(nil).should be_nil }
    end
  end

  describe "#link" do
    context "when is valid input" do
      it { subject.link(".a").should == "#{host}" }
      it { subject.link(".b").should == "#{host}/sports" }
      it { subject.link(".c").should == "#{host}/economy" }
      it { subject.link(".d").should == "#{host}//economy" }
      it { subject.link(".e").should == "#{host}/economy" }
    end
    context "when is invalid input" do
      it { subject.link(".absent").should be_nil }
      it { subject.link("").should be_nil }
      it { subject.link(nil).should be_nil }
    end
  end

  describe "#image" do
    context "when is valid input" do
      it { subject.image("img.a-img").should == "#{host}/images/logo.png" }
      it { subject.image("img.b-img").should == "#{host}/images/logo2.png" }
      it { subject.image("img.d-img").should == "#{host}/images/logo3.png" }
      it { subject.image("img.c-img").should == "#{host}/images/logo4.png" }
      it { subject.image("img.e-img").should == "#{host}/images/logo5.png" }
    end
    context "when is invalid input" do
      it { subject.image("img.absent").should be_nil }
      it { subject.image("").should be_nil }
      it { subject.image(nil).should be_nil }
    end
  end

  def parse(path)
    selector.parse(File.read(path))
  end
end
