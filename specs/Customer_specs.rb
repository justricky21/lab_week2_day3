require 'minitest/autorun'
require 'minitest/rg'
require_relative '../Customer'

class TestCustomer < MiniTest::Test

  def setup
    @customer1 = Customer.new("Raphael", 250, 28, 0)
    @customer2 = Customer.new("Ricardo", 250, 27, 0)
    @customer3 = Customer.new("Timmy", 25, 9, 27)
    @drink1 = Drink.new("Vodka martini", 10, 40)
    @drink2 = Drink.new("Caipirinha", 12, 50)
    @drink3 = Drink.new("Cuba libre", 8, 18)
    @pub1 = Pub.new("Dirty duck", 0, [@drink1, @drink2])
    @pub2 = Pub.new("Pato sujo", 0,  [@drink1, @drink2])
  end

  def test_buy_drink_clear_to_buy
    @customer1.buy_drink(@pub1, "Vodka martini")
    assert_equal(10, @pub1.till)
    assert_equal(240, @customer1.wallet)
  end

  def test_buy_drink_increase_drunkenness
    @customer1.buy_drink(@pub1, "Vodka martini")
    assert_equal(40, @customer1.drunkenness)
  end

  def test_buy_drink_under_age
    @customer3.buy_drink(@pub1, "Vodka martini")
    assert_equal(0, @pub1.till)
    assert_equal(25, @customer3.wallet)
  end

  def test_buy_drink_too_drunk
    @customer2.buy_drink(@pub1, "Vodka martini")
    @customer2.buy_drink(@pub1, "Vodka martini")
    @customer2.buy_drink(@pub1, "Vodka martini")
    @customer2.buy_drink(@pub1, "Vodka martini")
    @customer2.buy_drink(@pub1, "Vodka martini")
    assert_equal(40, @pub1.till)
    assert_equal(210, @customer2.wallet)
  end

  def test_buy_drink_found_drink
    found = @customer1.buy_drink(@pub1, "Vodka martini")
    assert_equal(true, found)
  end

  def test_buy_drink_not_found_drink
    found = @customer3.buy_drink(@pub1, "Cuba libre")
    assert_equal(false, found)
  end

  # what our method does is this:
  # def buy_drink(@pub1, @drink1)
  #   @wallet -= @drink1.price
  #   @pub1.till += @drink1.price
  # end

end
