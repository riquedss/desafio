require 'json'

class Db
  NOME_BD = './storage/db-desafio-musica.txt'.freeze
  MODO_LEITURA = 'r'.freeze
  MODO_ESCRITA_END = 'a'.freeze

  def initialize
    @db = nil
  end

  def find(chave)
    @db = abrir_conexao(MODO_LEITURA)
    linhas = @db.readlines
    fechar_conexao

    linhas.each do |linha|
      tupla = JSON.parse(linha.gsub('\n', ''))

      return tupla[1] if tupla[0].eql?(chave)
    end
  end

  def escrever(chave, valor)
    @db = abrir_conexao(MODO_ESCRITA_END)

    @db.write(estrutura_tupla(chave, valor)) unless @db.nil?

    fechar_conexao
  end

  private

  def abrir_conexao(modo)
    File.open(NOME_BD, modo)
  rescue StandardError
    nil
  end

  def fechar_conexao
    @db.close unless @db.nil?
  end

  def estrutura_tupla(chave, valor)
    "#{[chave, valor].to_json}\n"
  end
end
