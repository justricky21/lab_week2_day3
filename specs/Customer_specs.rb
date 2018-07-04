require 'minitest/autorun'
require 'minitest/rg'
require_relative '../Customer'

class TestCustomer < MiniTest::Test

  def setup
    @customer1 = Customer.new("Raphael", 25000)
    @customer2 = Customer.new("Ricardo", 25000)
    @drink1 = Drink.new("Vodka martini", 10)
    @drink2 = Drink.new("Capirinha", 12)
    @pub1 = Pub.new("Dirty duck", 0, [@drink1, @drink2])
    @pub2 = Pub.new("Pato sujo", 0,  [@drink1, @drink2])
  end

  def test_buy_drink
    assert_equal(0, @pub1.till)
    @customer1.buy_drink(@pub1, @drink1)
    assert_equal(10, @pub1.till)
    assert_equal(24990, @customer1.wallet)
  end

  # what our method does is this:
  # def buy_drink(@pub1, @drink1)
  #   @wallet -= @drink1.price
  #   @pub1.till += @drink1.price
  # end


end
