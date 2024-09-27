require "json"
WIN1 = 1
WIN2 = 2
EMPATE = 0

class Hero
  def initialize(hero)
    @hero = hero
  end
  
  def name
    @hero["name"]
  end

  def powerstats
    @hero["powerstats"]
  end
  
  def field_value(field)
    return 0 unless powerstats.has_key?(field)
    
    powerstats[field].to_i
  end
  
  def total_power
    powerstats_fields.sum { |field_name| field_value(field_name) }
  end

  def powerstats_fields
    ["intelligence","strength","speed","durability","power","combat"]
  end
end

class Championship
  def initialize(heroes)
    @heroes = heroes
  end

  def start
    # como fazer pra verificar se é null antes? if @heroes == nil?
    if @heroes.length === 0
      puts "Nenhum herói informado!!"
      return
    end

    @count = 0
    while @heroes.length > 1
      @count += 1

      load_fighters

      fight = Championship::Fight.new(@hero1, @hero2, @count)

      fight_result = fight.init

      if (fight_result == WIN1)
        @heroes.delete(@hero2)
      elsif (fight_result == WIN2)
        @heroes.delete(@hero1)
      elsif (@heroes.length == 2)
        # empate entre os dois últimos fighters
        # se empatar entre mais que dois fica em looping infinito =/
        break 
      end
    end

    print_result_championship
  end

  private

  def load_fighters
    hero1_index = Random.rand(@heroes.length)
    
    hero2_index = hero1_index
    while hero2_index == hero1_index
      hero2_index = Random.rand(@heroes.length)      
    end

    @hero1 = @heroes[hero1_index]
    @hero2 = @heroes[hero2_index]
  end

  def print_result_championship
    if @heroes.length > 1
      puts "\n\Draw between #{@heroes[0].name} and #{@heroes[1].name}!"  
      return
    end

    puts "\n\n#{@heroes[0].name} is the great champion!"
  end
end

class Championship::Fight
  def initialize(hero1, hero2, count)
    @hero1 = hero1
    @hero2 = hero2
    @count = count
    @hero1_points = 0
    @hero2_points = 0
  end

  def init
    puts "\n == fight #{@count}: #{@hero1.name} vs #{@hero2.name} ==\n\n"
    fight
    
    result = result_fight
    
    print_fight_result(result)

    result
  end

  private

  def fight
    @hero1.powerstats_fields.each do | field |
      fight_field_result = fight_field(field)
      
      if (fight_field_result == WIN1)
        @hero1_points += 1
      elsif (fight_field_result == WIN2)
        @hero2_points += 1
      end
      
      print_fight_field_result(field, fight_field_result)
    end
  end

  def result_fight
    result = fight_values(@hero1_points, @hero2_points)

    return fight_total_power if result == EMPATE

    result
  end
  
  def fight_field(field)
    value1 = @hero1.field_value(field)
    value2 = @hero2.field_value(field)

    fight_values(value1, value2)
  end

  def fight_total_power
    fight_values(@hero1.total_power, @hero2.total_power)
  end

  def fight_values(value1, value2)
    return WIN1 if value1 > value2
    return WIN2 if value2 > value1
    EMPATE
  end

  def print_fight_field_result(field, result)
    field_print = "-> #{field}:"
    if (result == EMPATE)
      puts "#{field_print} Draw (#{@hero1_points} x #{@hero2_points})"
      return
    end

    winner_name = result == WIN1 ? @hero1.name : @hero2.name

    puts "#{field_print} #{winner_name} +1 (#{@hero1_points} x #{@hero2_points})"
  end

  def print_fight_result(result)
    if (result == WIN1)
      puts "\n#{@hero1.name} WINS!!"
    elsif (result == WIN2)
      puts "\n#{@hero2.name} WINS!!"
    else
      puts "\nDraw!"
    end
  end
end

file = File.read("./heroes.json") 
heroes_json = JSON.parse(file)

heroes = heroes_json.map { |hero| Hero.new(hero) }

championship = Championship.new(heroes)

championship.start