Movie filter

- É um script CLI que lê os inputs do usuário (com ARGV) e filtra cartas de magic em um JSON
- Os filmes podem ser filtrados por gênero (Genre) ou ano de lançamento (Year)
- Funciona da seguinte maneira:

$ ruby movie_filter.rb Genre=Action Year=2014

Output:

- Nome do filme 1
- Nome do filme 2
- Nome do filme 3

- O JSON com os filmes está na pasta desse módulo

Lendo JSON com ruby

$ gem install json

No arquivo:

file = File.read('./movies.json')
informacao_em_array_e_hash = JSON.parse(file)    

Dicas

- Utilizar a gem byebug para debugar
- Utilizar rubocop para formatação
- Se quiser deixar mais desafiador, da para criar um que filtra por qualquer um dos campos do json

O que é praticado nesse projeto:

- Programação funcional
- (bastante) Operações com strings, hashs e arrays
- Loops / Blocks
- Condicionais
- Utilização de gems

Run tests

rspec