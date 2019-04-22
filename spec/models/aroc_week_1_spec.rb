require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 1' do

# Looking for your test setup data?
# It's currently inside /spec/rails_helper.rb
# Not a very elegant solution, but works for this iteration.

# Here are the docs associated with ActiveRecord queries: http://guides.rubyonrails.org/active_record_querying.html

# ----------------------


  it '1. finds orders by amount' do
    # ----------------------- Using Ruby -------------------------
    orders_of_500 = Order.all.select { |order| order.amount == 500 }
    orders_of_200 = Order.all.select { |order| order.amount == 200 }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_of_500.count).to eq(1)
    expect(orders_of_200.count).to eq(1)
  end

  it '2. finds order id of smallest order' do
    # ----------------------- Using Raw SQL ----------------------
    order_id = ActiveRecord::Base.connection.execute('SELECT id FROM orders ORDER BY amount ASC LIMIT 1').first['id']
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # Your solution should not contain the ID of the order anywhere
    # ------------------------------------------------------------

    # Expectation
    expect(order_id).to eq(@order_1.id)
  end

  it '3. finds order id of largest order' do
    # ----------------------- Using Raw SQL ----------------------
    order_id = ActiveRecord::Base.connection.execute('SELECT id FROM orders ORDER BY amount DESC LIMIT 1').first['id']
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # Your solution should not contain the ID of the order anywhere
    # ------------------------------------------------------------

    # Expectation
    expect(order_id).to eq(@order_15.id)
  end

  it '4. finds orders of multiple amounts' do
    # ----------------------- Using Ruby -------------------------
    orders_of_500_and_700 = Order.all.select do |order|
      order.amount == 500 || order.amount == 700
    end

    orders_of_700_and_1000 = Order.all.select do |order|
      order.amount == 700 || order.amount == 1000
    end
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_of_500_and_700.count).to eq(2)
    expect(orders_of_700_and_1000.count).to eq(2)
  end

  it '5. finds multiple items by id' do
    ids_to_find = [@item_1.id, @item_2.id, @item_4.id]
    expected_objects = [@item_1, @item_4, @item_2]

    # ----------------------- Using Ruby -------------------------
    items = Item.all.select { |item| ids_to_find.include?(item.id) }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(items).to eq(expected_objects)
  end

  it '6. finds multiple orders by id' do
    ids_to_find = [@order_1.id, @order_3.id, @order_5.id, @order_7.id]

    # ----------------------- Using Ruby -------------------------
    orders = Order.all.select { |order| ids_to_find.include?(order.id) }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders).to eq([@order_3, @order_5, @order_1, @order_7])
  end

  it '7. finds orders with an amount between 700 and 1000' do
    expected_result = [@order_11, @order_13, @order_8, @order_10, @order_15, @order_14, @order_12]
    # ----------------------- Using Ruby -------------------------
    orders_between_700_and_1000 = Order.all.select { |order| order.amount >= 700 && order.amount <= 1000 }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_between_700_and_1000).to eq(expected_result)
  end

  it '8. finds orders with an amount less than 550' do
    expected_result = [@order_3, @order_2, @order_1, @order_4]

    # ----------------------- Using Ruby -------------------------
    orders_less_than_550 = Order.all.select { |order| order.amount < 550 }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_less_than_550).to eq(expected_result)
  end
end
