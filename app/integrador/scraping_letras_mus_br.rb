require 'httparty' 
require 'nokogiri'
require '../model/musica.rb'

class ScrapingLetrasMusBr
  URL_DOWNLOAD = "https://www.letras.mus.br/padre-marcelo-rossi/47896/"
  NOME = "Erguei As Mãos"
  NOME_AUTOR = "Padre Marcelo Rossi"
  ID = "47896"

  def self.scraping!
    response = download()

    letra = get_letra(response)

    Musica.new(ID, NOME, letra, NOME_AUTOR).save
  end

  def self.download()
    HTTParty.get(URL_DOWNLOAD)
  end

  def self.get_letra(response)
    document = Nokogiri::HTML(response.body)
    letra_completa = document.css("div.lyric-original").css("p")

    estrofes = ""

    letra_completa.each do |html_p|
      estrofe = ""
      html_p.children.each do |linha|
        if linha.text?
          estrofe += linha.text
        else
          estrofe += "\n"
        end
      end

      estrofes += "#{estrofe}\n\n"
    end

    estrofes
  end
end
