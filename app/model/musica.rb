require '../../db/db.rb'

class Musica
  attr_accessor :id, :nome, :letra, :nome_autor

  def initialize(id, nome, letra, nome_autor)
    @id = id
    @nome = nome
    @letra = letra
    @nome_autor = nome_autor
  end

  def save
    Db.new.escrever(@id, { id: @id, nome: @nome, letra: @letra, nome_autor: @nome_autor })
  end

  def self.find(id)
    Db.new.find(id)
  end
end
