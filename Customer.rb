require_relative 'pub'
require_relative 'drink'
require_relative 'food'

class Customer
  attr_reader :wallet, :drunkenness
  def initialize(arg1, arg2, arg3, arg4)
    @name = arg1
    @wallet = arg2
    @age = arg3
    @drunkenness = arg4
  end

  # takes: age, wallet, drunkenness
  # takes(drink): name, price, alcohol_level
  # takes(pub): till, drinks
  # returns: true, false

  def buy_drink(pub, drink)
    if (@age >= 18) && (@drunkenness < 150)
      for each in pub.drinks
        if each.name == drink
          @wallet -= each.price
          pub.till += each.price
          @drunkenness += each.alcohol_level
          return true
        end
      end
    end
    return false
  end

  # takes: age, wallet, drunkennes
  # takes(food): name, price, refreshment_level
  # takes(pub): till, foods
  # returns: true, false

  def buy_food(pub, food)
    if (@age >= 18) && (@drunkenness < 150)
      for each in pub.foods
        if each.name == food
          @wallet -= each.price
          pub.till += each.price
          @drunkenness -= each.rejuvenation_level
          return true
        end
      end
    end
    return false
  end


end
