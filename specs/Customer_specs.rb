require 'minitest/autorun'
require 'minitest/rg'
require_relative '../Customer'

class TestCustomer < MiniTest::Test

  def setup
    @customer1 = Customer.new("Raphael", 250, 28, 0)
    @customer2 = Customer.new("Ricardo", 250, 27, 100)
    @customer3 = Customer.new("Timmy", 25, 9, 27)
    @drink1 = Drink.new("Vodka martini", 10, 40)
    @drink2 = Drink.new("Caipirinha", 12, 50)
    @drink3 = Drink.new("Cuba libre", 8, 18)
    @food1 = Food.new("Chips", 3, 10)
    @food2 = Food.new("Fish and chips", 7, 30)
    @food3 = Food.new("Deep-fried mars bars", 1, 5)
    @pub1 = Pub.new("Brudna kaczka", 0, [@drink1, @drink2], [@food1, @food3])
    @pub2 = Pub.new("Pato sujo", 0,  [@drink1, @drink2], [@food1, @food2])
  end

  def test_buy_food_clear_to_buy
    @customer1.buy_food(@pub1, "Chips")
    assert_equal(3, @pub1.till)
    assert_equal(247, @customer1.wallet)
  end

  def test_buy_food_found_food
    found = @customer1.buy_food(@pub1, "Deep-fried mars bars")
    assert_equal(true, found)
  end

  def test_buy_food_not_found_food
    found = @customer1.buy_food(@pub1, "Fish and chips")
    assert_equal(false, found)
  end

  def test_buy_food_under_age
    @customer3.buy_food(@pub1,"Deep-fried mars bars")
    assert_equal(0, @pub1.till)
    assert_equal(25, @customer3.wallet)
  end

  def test_buy_food_decrese_drunkenness
    @customer2.buy_food(@pub1, "Chips")
    assert_equal(90, @customer2.drunkenness)
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
    assert_equal(20, @pub1.till)
    assert_equal(230, @customer2.wallet)
  end

  def test_buy_drink_found_drink
    found = @customer1.buy_drink(@pub1, "Vodka martini")
    assert_equal(true, found)
  end

  def test_buy_drink_not_found_drink
    found = @customer3.buy_drink(@pub1, "Cuba libre")
    assert_equal(false, found)
  end

end
