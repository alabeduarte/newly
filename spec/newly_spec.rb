require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
# require 'spec_helper'

describe Newly do
  let(:ec_bahia) { ec_bahia = Newly.new('http://www.ecbahia.com', 'spec/html/ecbahia.html') }
  let(:g1) { g1_bahia = Newly.new('http://g1.globo.com', 'spec/html/g1.html') }
  let(:g1_bahia) { g1_bahia = Newly.new('http://g1.globo.com/bahia/', 'spec/html/g1_bahia.html') }
  let(:metro1) { g1_bahia = Newly.new('http://www.metro1.com.br/portal/?varSession=noticia&varEditoria=cidade', 'spec/html/metro1_cidade.html') }
  
  it "should fetch ecbahia title" do
    ec_bahia.title.should == "ecbahia.com - \u00e9 goleada tricolor na internet!  (ecbahia, ecbahia.com, ecbahia.com.br, Esporte Clube Bahia)"
  end
  
  it "should fetch highlights from http://g1.globo.com/bahia" do
    highlights = g1_bahia.highlights( selector: '#ultimas-regiao div, #ultimas-regiao ul li',
                                      url: 'a',
                                      date: '.data-hora',
                                      title: '.titulo',
                                      subtitle: '.subtitulo',
                                      image: 'img'
                                      )
    highlights.should_not be_empty
  end
  
  context "fetching news from http://g1.globo.com" do
    it "should fetch highlights news" do
      highlights = g1.highlights( selector: '#glb-corpo .glb-area .chamada-principal',
                                        url: 'a',
                                        title: '.chapeu',
                                        subtitle: '.subtitulo',
                                        image: '.foto a img'
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
                                        url: 'a',
                                        title: '.chapeu',
                                        subtitle: '.subtitulo',
                                        image: '.foto a img'
                                        )
      highlights[0].url.should == 'http://g1.globo.com/mundo/noticia/2012/08/ira-encerra-resgate-apos-terremotos-e-revisa-mortos-para-227-diz-tv-estatal.html'
      highlights[0].keywords.should == 'noticias, noticia, Mundo'
    end
  end
  
  it "should fetch highlights from http://www.metro1.com.br" do
    highlights = metro1.highlights( selector: '#lista-de-resultados .resultado',
                                      url: 'a',
                                      date: '.resultado-data',
                                      title: '.resultado-titulo',
                                      subtitle: '.resultado-texto',
                                      image: 'a img.img-resultado',
                                      host: 'http://www.metro1.com.br'
                                      )
    highlights.should_not be_empty
  end
end
