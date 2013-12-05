class BottlesSong
  def sing
    verses(99, 0)
  end

  def verses(upper_bound, lower_bound)
    upper_bound.downto(lower_bound).map {|n| verse(n) + "\n"}.join
  end

  def verse(number)
    BeerVerse.new(strategy(number)).to_s
  end
  
  def strategy(number)
    begin 
      Object.const_get("VerseStrategy#{number}")
    rescue NameError => e
      VerseStrategy
    end.new(number)
  end
end

class BeerVerse
  attr_reader :strategy
  
  def initialize(strategy)
    @strategy = strategy
  end

  def to_s
    "#{starting_count} #{starting_container} of beer on the wall, ".capitalize +
    "#{starting_count} #{starting_container} of beer.\n" +
    "#{action}, " +
    "#{ending_count} #{ending_container} of beer on the wall.\n"
  end

  private

  def starting_count
    strategy.starting_count
  end

  def starting_container
    strategy.starting_container
  end

  def action
    strategy.action
  end

  def ending_count
    strategy.ending_count
  end

  def ending_container
    strategy.ending_container
  end
end

class VerseStrategy
  attr_reader :number
  
  def initialize(number)
    @number = number
  end
  
  def starting_count
    number
  end

  def starting_container
    'bottles'
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    'one'
  end

  def ending_count
    number - 1
  end

  def ending_container
    'bottles'
  end
  
end

class VerseStrategy0 < VerseStrategy
  def starting_count
    'no more'
  end
  
  def action
    "Go to the store and buy some more"
  end
  
  def ending_count
    99
  end
end

class VerseStrategy1 < VerseStrategy
  def starting_container
    'bottle'
  end
  
  def pronoun
    'it'
  end
  
  def ending_count
    'no more'
  end
      
end

class VerseStrategy2 < VerseStrategy
  def ending_container
    'bottle'
  end
end