class Musica
  attr_accessor :nome, :letra, :nome_autor

  def initialize(nome, letra, nome_autor)
    @nome = nome
    @letra = letra
    @nome_autor = nome_autor
  end
end
