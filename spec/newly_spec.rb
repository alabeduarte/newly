require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
# require 'spec_helper'

describe Newly do
  let(:selector) { Nokogiri::HTML }
  let(:ec_bahia) { Newly.new('http://www.ecbahia.com', parse('spec/html/ecbahia.html')) }
  let(:g1) { Newly.new('http://g1.globo.com', parse('spec/html/g1.html')) }
  let(:g1_bahia) { Newly.new('http://g1.globo.com/bahia/', parse('spec/html/g1_bahia.html')) }
  let(:metro1) { Newly.new('http://www.metro1.com.br/portal/?varSession=noticia&varEditoria=cidade', parse('spec/html/metro1_cidade.html')) }
  let(:terra) { Newly.new('http://noticias.terra.com.br/ultimasnoticias/0,,EI188,00.html', parse('spec/html/terra.html')) }

  it "should fetch ecbahia title" do
    ec_bahia.title.should == "ecbahia.com - \u00e9 goleada tricolor na internet!  (ecbahia, ecbahia.com, ecbahia.com.br, Esporte Clube Bahia)"
  end

  it "should fetch highlights from http://g1.globo.com/bahia" do
    highlights = g1_bahia.highlights( selector: '#ultimas-regiao div, #ultimas-regiao ul li',
                                      href: 'a',
                                      date: '.data-hora',
                                      title: '.titulo',
                                      subtitle: '.subtitulo',
                                      img: 'img'
                                      )
    highlights.should_not be_empty
  end

  context "fetching news from http://g1.globo.com" do
    it "should fetch highlights news" do
      highlights = g1.highlights( selector: '#glb-corpo .glb-area .chamada-principal',
                                        href: 'a',
                                        title: '.chapeu',
                                        subtitle: '.subtitulo',
                                        img: '.foto a img'
                                        )
      highlights.should_not be_empty
      highlights[0].url.should == 'http://g1.globo.com/mundo/noticia/2012/08/ira-encerra-resgate-apos-terremotos-e-revisa-mortos-para-227-diz-tv-estatal.html'
      highlights[0].subtitle.should == 'Tremores deixaram 1.380 pessoas feridas.'

      highlights[1].url.should == 'http://g1.globo.com/politica/mensalao/noticia/2012/08/historias-de-togas-e-becas-alimentam-folclore-de-tribunais-veja-algumas.html'
      highlights[1].title.should == 'julgamento no stf'

      highlights[2].url.should == 'http://g1.globo.com/concursos-e-emprego/noticia/2012/08/fazenda-e-9-orgaos-abrem-inscricoes-para-12-mil-vagas-na-segunda.html'
      highlights[2].title.should == 'a partir de amanha'
    end

    xit "should fetch keywords" do
      highlights = g1.highlights( selector: '#glb-corpo .glb-area .chamada-principal',
                                        href: 'a',
                                        title: '.chapeu',
                                        subtitle: '.subtitulo',
                                        img: '.foto a img'
                                        )
      highlights[0].url.should == 'http://g1.globo.com/mundo/noticia/2012/08/ira-encerra-resgate-apos-terremotos-e-revisa-mortos-para-227-diz-tv-estatal.html'
      highlights[0].keywords.should == 'noticias, noticia, Mundo'
    end
  end

  it "should fetch highlights with relative urls from http://www.metro1.com.br" do
    highlights = metro1.highlights( selector: '#lista-de-resultados .resultado',
                                      href: 'a',
                                      date: '.resultado-data',
                                      title: '.resultado-titulo',
                                      subtitle: '.resultado-texto',
                                      img: 'a img.img-resultado',
                                      host: 'http://www.metro1.com.br/portal'
                                      )
    highlights.should_not be_empty
    highlights[0].url.should == 'http://www.metro1.com.br/portal/?varSession=noticia&varEditoriaId=5&varId=16098'
  end

  context "fetching news from http://noticias.terra.com.br" do
    it "should fetch highlights news" do
      highlights = terra.highlights(selector: 'div.articles li',
                                      href: 'a',
                                      title: 'strong',
                                      subtitle: '',
                                      img: '',
                                      date: '')
      highlights.should_not be_empty
      highlights[0].url.should == 'http://noticias.terra.com.br/eleicoes/2012/rj/rio-de-janeiro/noticias/0,,OI6133651-EI20647,00-Maia+descarta+rejeicao+tenho+que+crescer+onde+tenho+chances.html'
      highlights[0].title.should == 'Maia descarta rejeicao: "tenho que crescer onde tenho chances"'

      highlights[1].url.should == 'http://noticias.terra.com.br/mundo/noticias/0,,OI6133649-EI294,00-Ataque+aereo+mata+guerrilheiros+das+Farc+na+Colombia.html'
      highlights[1].title.should == 'Ataque aereo mata 3 guerrilheiros das Farc na Colombia'

      highlights[2].url.should == 'http://noticias.terra.com.br/mundo/noticias/0,,OI6133652-EI294,00-Pesquisa+revela+utilidade+de+do+DNA+que+era+visto+como+lixo.html'
      highlights[2].title.should == 'Pesquisa revela utilidade de 99% do DNA que era visto como "lixo"'
    end
  end

private
  def parse(path)
    selector.parse(File.read(path))
  end
end
