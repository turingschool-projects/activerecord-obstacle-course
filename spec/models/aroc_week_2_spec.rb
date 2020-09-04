require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 2' do

# Looking for your test setup data?
# It's currently inside /spec/rails_helper.rb
# Not a very elegant solution, but works for this iteration.

# Here are the docs associated with ActiveRecord queries: http://guides.rubyonrails.org/active_record_querying.html

# ----------------------


  it '9. finds orders for a user' do
    expected_result = [@order_3, @order_15, @order_9, @order_12]

    # ----------------------- Using Ruby -------------------------
    orders_of_user_3 = Order.all.select { |order| order.user_id == @user_3.id }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_of_user_3).to eq(expected_result)
  end

  it '10. sorts the orders from most expensive to least expensive' do
    expected_result = [
      @order_15, @order_14, @order_13, @order_12, @order_11,
      @order_10, @order_8, @order_9, @order_7, @order_6,
      @order_5, @order_4, @order_3, @order_2, @order_1
    ]

    # ----------------------- Using Ruby -------------------------
    orders = Order.all.sort_by { |order| order.amount }.reverse
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '11. sorts the orders from least expensive to most expensive' do
    expected_result = [
      @order_1, @order_2, @order_3, @order_4, @order_5,
      @order_6, @order_7, @order_9, @order_8, @order_10,
      @order_11, @order_12, @order_13, @order_14, @order_15
    ]

    # ----------------------- Using Ruby -------------------------
    orders = Order.all.sort_by { |order| order.amount }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '12. should return all items except items 2, 5 and 6' do
    items_not_included = [@item_2, @item_5, @item_6]
    expected_result = [
      @item_1, @item_4, @item_9, @item_10,
      @item_3, @item_8, @item_7
    ]

    # ----------------------- Using Ruby -------------------------
    items = Item.all.map { |item| item unless items_not_included.include?(item) }.compact
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(items.sort).to eq(expected_result.sort)
  end

  it "13. groups an order's items by name" do
    expected_result = [@item_4, @item_2, @item_5, @item_3]

    # ----------------------- Using Ruby -------------------------
    order = Order.find(@order_3.id)
    grouped_items = order.items.sort_by { |item| item.name }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(grouped_items).to eq(expected_result)
  end

  it '14. plucks all values from one column' do
    expected_result = ['Abercrombie', 'Banana Republic', 'Calvin Klein', 'Dickies', 'Eddie Bauer', 'Fox', 'Giorgio Armani', 'Hurley', 'Izod', 'J.crew']

    # ----------------------- Using Ruby -------------------------
    names = Item.all.map(&:name)
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(names).to eq(expected_result)
  end

  it '15. gets all item names associated with all orders' do
    expected_result = [
      'Dickies', 'Giorgio Armani', 'Banana Republic', 'Eddie Bauer',
      'Eddie Bauer', 'Banana Republic', 'J.crew', 'Calvin Klein',
      'Abercrombie', 'Eddie Bauer', 'Banana Republic', 'J.crew',
      'Abercrombie', 'Dickies', 'Giorgio Armani', 'Abercrombie',
      'Abercrombie', 'Dickies', 'Giorgio Armani', 'Abercrombie',
      'Dickies', 'Giorgio Armani', 'Banana Republic', 'J.crew',
      'Dickies', 'Giorgio Armani', 'Izod', 'Calvin Klein',
      'Eddie Bauer', 'Izod', 'Calvin Klein', 'Fox',
      'Abercrombie', 'Eddie Bauer', 'Banana Republic', 'J.crew',
      'Abercrombie', 'Banana Republic', 'Eddie Bauer', 'J.crew',
      'Abercrombie', 'Dickies', 'Giorgio Armani', 'Abercrombie',
      'Giorgio Armani', 'Banana Republic', 'Izod', 'Fox',
      'Giorgio Armani', 'Eddie Bauer', 'Izod', 'Calvin Klein',
      'Abercrombie', 'Eddie Bauer', 'J.crew', 'Calvin Klein',
      'Abercrombie', 'Giorgio Armani', 'J.crew', 'Fox',
    ]

    # ----------------------- Using Ruby -------------------------
    names = Order.all.map do |order|
      if order.items
        order.items.map { |item| item.name }
      end
    end

    names = names.flatten
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(names.sort).to eq(expected_result.sort)
  end
end
