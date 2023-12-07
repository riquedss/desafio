require './app/terminal/terminal.rb'

Terminal.bemvindo

bool = true

while bool
  Terminal.opcoes
  print("\n> ")
  opcao_digitada = gets.chomp
  Terminal.delegador(opcao_digitada)

  puts "Digite (n) para não executar mais música e sair?\n"
  opcao_digitada = gets.chomp
  return if opcao_digitada.eql?('n')
  
end

