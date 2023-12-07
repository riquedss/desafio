require './app/tocador/tocador.rb'

module Terminal
  def self.bemvindo 
    puts "=========================================================="
    puts "===                                                    ==="
    puts "===    SEJA BEM VINDO AO REPRODUTOR DE MÚSICA          ==="
    puts "===                                                    ==="
    puts "=========================================================="
  end

  def self.opcoes
    puts "o que você deseja fazer?\n\n"

    puts "Escolha e digite no prompt abaixo uma da opções a seguir:"
    puts "(1) Reproduzir a música completa normalmente"
    puts "(2) Reproduzir a música completa generalizada"
    puts "(3) Reproduzir a parte de uma música normalmente"
  end

  def self.delegador(opcao)
    tocador = Tocador.new("47896")
    case opcao
    when '1'
        tocador.tocar_musica_completa
    when '2'
        tocador.tocar_musica_completa_generica
    when '3'
        tocador.tocar_musica_por_parte(0)
    end

  end
end
