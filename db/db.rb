require 'json'

class Db
  NOME_BD = '../../db/storage/db-desafio-musica.txt'.freeze
  MODO_LEITURA = 'r'.freeze
  MODO_ESCRITA_END = 'a'.freeze

  def initialize; end

  def find(chave)
    db_conexao = abrir_conexao(MODO_LEITURA)
    linhas = db_conexao.readlines
    fechar_conexao(db_conexao)

    linhas.each do |linha|
      tupla = JSON.parse(linha.gsub('\n', ''))

      return tupla[1] if tupla[0].eql?(chave)
    end

    nil
  end

  def escrever(chave, valor)
    db_conexao = abrir_conexao(MODO_ESCRITA_END)

    db_conexao.write(estrutura_tupla(chave, valor)) unless db_conexao.nil? || find(chave)

    fechar_conexao(db_conexao)
  end

  private

  def abrir_conexao(modo)
    File.open(NOME_BD, modo)
  rescue StandardError
    nil
  end

  def fechar_conexao(db_conexao)
    db_conexao.close unless db_conexao.nil?
  end

  def estrutura_tupla(chave, valor)
    "#{[chave, valor].to_json}\n"
  end
end
