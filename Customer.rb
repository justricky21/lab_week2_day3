require_relative 'pub'
require_relative 'drink'

class Customer
  attr_reader :wallet
  def initialize(arg1, arg2)
    @name = arg1
    @wallet = arg2
  end

# Process of buying:
# Take money from wallet
# Give money to pub
# money is based on drink's price
# pub gives you drink

  def buy_drink(pub, drink)
    @wallet -= drink.price
    pub.till += drink.price
  end


end
