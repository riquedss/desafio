require './db/db.rb'

class Musica
  attr_accessor :id, :nome, :letra, :nome_autor, :duracao, :trecho_particionador

  def initialize(id, nome, letra, nome_autor, duracao, trecho_particionador)
    @id = id
    @nome = nome
    @letra = letra
    @nome_autor = nome_autor
    @duracao = duracao
    @trecho_particionador = trecho_particionador
  end

  def letra_completa
    @letra
  end

  def particionar_letra
    return @letra.split(@trecho_particionador)
  end

  def count_frase
    @letra.gsub("\n\n", "\n").split("\n").length
  end

  def save
    Db.new.escrever(@id, { id: @id, nome: @nome, letra: @letra, 
                           nome_autor: @nome_autor, duracao: @duracao, 
                           trecho_particionador: @trecho_particionador })
  end

  def self.find(id)
    musica_bd = Db.new.find(id)

    new(musica_bd["id"], musica_bd["nome"], musica_bd["letra"], 
        musica_bd["nome_autor"], musica_bd["duracao"], musica_bd["trecho_particionador"]) if musica_bd
  end
end
