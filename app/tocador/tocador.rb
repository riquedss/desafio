require './app/model/musica.rb'
require './app/integrador/scraping_letras_mus_br.rb'

class Tocador
  INDICADORES_REPETICAO = ["Erguei as mãos", "Os animaizinhos", "O senhor tem muitos filhos"]


  def initialize(musica_id)
    @musica = get_musica_or_get_in_site(musica_id)
    @tempo_por_frase_in_segundos = @musica.duracao.to_f / @musica.count_frase
  end

  def tocar_musica_completa
    tocar!(@musica.letra_completa)
  end

  def tocar_musica_completa_generica
    r1 = true
    r2 = true
    r3 = true
    nova_musica = ""
    @musica.letra_completa.split("\n\n").each do |linha|
      if r1 && linha.include?("Erguei as mãos")
        nova_musica += "#{linha}\n\n"
        r1 = false
      elsif r2 && linha.include?("Os animaizinhos")
        nova_musica += "#{linha}\n\n"
        r2 = false
      elsif r3 && linha.include?("O senhor tem muitos filhos")
        nova_musica += "#{linha}\n\n"
        r3 = false
      end
    end

    tocar!(nova_musica )


  end

  def tocar_musica_por_parte(parte)
    tocar!(@musica.particionar_letra[parte])
  end

  private

  def tocar!(letra_corrente)
    letra_corrente.split("\n").each do |linha|
      puts linha
      sleep(@tempo_por_frase_in_segundos)
      system("clear")  if linha.empty?
    end

  end

  def get_musica_or_get_in_site(musica_id)
    musica = get_musica(musica_id)

    return musica if musica

    ScrapingLetrasMusBr.scraping!
    get_musica(musica_id)
  end

  def get_musica(musica_id)
    Musica.find(musica_id)
  end
end
