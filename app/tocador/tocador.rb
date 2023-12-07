require '../model/musica.rb'

class Tocador
  def initialize(musica_id)
    @musica = get_musica(musica_id)
    @tempo_por_frase_in_segundos = @musica.duracao.to_f / @musica.count_frase
  end

  def tocar_musica_completa
    tocar!(@musica.letra_completa)
  end

  def tocar_musica_por_parte(parte)
    tocar!(@musica.particionar_letra[parte])
  end

  private

  def tocar!(letra_corrente)
    puts @tempo_por_frase_in_segundos
    letra_corrente.split("\n").each do |linha|
      puts linha
      sleep(@tempo_por_frase_in_segundos)
      system("clear")  if linha.empty?
    end

  end

  def get_musica_or_get_in_site()
    musica = get_musica(musica_id)

    return musica if musica

    ScrapingLetrasMusBr.scraping!
    get_musica(musica_id)
  end

  def get_musica(musica_id)
    Musica.find(musica_id)
  end
end
