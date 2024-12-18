require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 4' do
  # To be successful, you should be familiar with: #find, #where, #order, #limit, #pluck

  # Looking for your test setup data?
  # It's currently inside /spec/test_data.rb
  # In there you will find a method `load_test_data` that will run for each `it` block
  before :each do
    load_test_data
  end

  # Here are the docs associated with ActiveRecord queries: http://guides.rubyonrails.org/active_record_querying.html

  # ----------------------

  ## How to complete these exercises:
  # Currently, these tests are passing because we're using Ruby to do it. Re-write the Ruby solutions using ActiveRecord.
  # ex. orders_of_500 = Order.where(...)
  # You can comment out the Ruby example after your AR is working.

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
    # HINT: This query does not need grouping or aggregating
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
end
