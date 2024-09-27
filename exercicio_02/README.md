# Campeonato de heróis

O que será fixado / reforçado:
- Organização de classes, atributos, regras de negócio e arquivos em Ruby
- require, require_relative
- loops, condicionais

Programe as classes do código a seguir:

```
heroes = []

heroes.map do |hero|
  Hero.new(hero)
end

battle = Championship.new(heroes)
battle.start
# == fight 1: A-Bomb vs Abe Sapien ==
#
# inteligence: Abe Sapien +1 (1 x 0)
# strenght: A-Bomb +1 (1 x 1)
# speed: Abe Sapien +1 (1 x 1)
# durability: A-Bomb +1 (2 x 1)
# power: Abe Sapien +1 (2 x 2)
# combat: Abe Sapien +1 (2 x 3)
#
# Abe Sapien wins!
#
# == fight 2: Foo vs Bar ==
# ...
# == fight 3: Lorem vs Ipsum ==
# ...
# 
# Bionic Woman is the great champion!

```

Regras do campeonato:
- Uma luta acontece de cada vez, e os 2 participantes são selecionados aleatóriamente da lista
- Durante a luta, os atributos dos participantes são verificados um a um, quem tiver o atributo maior soma 1 ponto
- Ganha a luta quem tiver mais pontos
- No caso de empate de pontos, para cada participante lutando, todos os valores dos atributos devem ser somados, quem tiver a maior soma ganha
- Quem ganhar continua na lista de participantes para o sorteio da próxima luta
- Quem perder é removido da lista de participantes
- O campeonato termina quando sobrar apenas 1 elemento na lista de participantes, no caso, quem vencer

Requisitos:
- Além das classes Hero e Championship, deverá haver uma classe Championship::Fight, responsável por receber dois participantes, realizar a lógica da luta e retornar quem vencer:

Fight.new(hero1, hero2)
Fight.init

winner = Fight.winner

* O andamento do campeonato deve ser printado no console até o seu final como no exemplo dos comentários
* O json disponível nessa mesma pasta contêm vários personagens, com o nome do personagem na chave `name` e atributos na chave `powerstats`
* Se quiser adicionar novas ideias o importante é praticar