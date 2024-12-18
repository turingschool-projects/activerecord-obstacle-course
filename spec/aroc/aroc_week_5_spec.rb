require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 5' do
  # To be successful, you should be familiar with: #find, #where, #order, #limit, #pluck, #sum, #average, #distinct, #joins

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

  it '16. returns the names of users who ordered one specific item' do
    expected_result = [@user_2.name, @user_3.name, @user_1.name]

    # ----------------------- Using Raw SQL-----------------------
    users = ActiveRecord::Base.connection.execute("
      select
        distinct users.name
      from users
        join orders on orders.user_id=users.id
        join order_items ON order_items.order_id=orders.id
      where order_items.item_id=#{@item_8.id}
      ORDER BY users.name")
    users = users.map {|u| u['name']}
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(users).to eq(expected_result)
  end

  it '17. returns the name of items associated with a specific order' do
    expected_result = ['Abercrombie', 'Giorgio Armani', 'J.crew', 'Fox']

    # ----------------------- Using Ruby -------------------------
    names = Order.last.items.all.map(&:name)
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(names.sort).to eq(expected_result.sort)
  end

  it '18. returns the names of items for a users order' do
    expected_result = ['Giorgio Armani', 'Banana Republic', 'Izod', 'Fox']

    # ----------------------- Using Ruby -------------------------
    items_for_user_3_third_order = []
    grouped_orders = []

    Order.all.each do |order|
      if order.items
        grouped_orders << order if order.user_id == @user_3.id
      end
    end

    grouped_orders.each_with_index do |order, idx|
      items_for_user_3_third_order = order.items.map(&:name) if idx == 2
    end
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(items_for_user_3_third_order).to match_array(expected_result)
  end

  it '19. returns the average amount for all orders' do
    # ---------------------- Using Ruby -------------------------
    average = (Order.all.map(&:amount).inject(:+)) / (Order.count)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(average).to eq(650)
  end

  it '20. returns the average amount for all orders for one user' do
    # ---------------------- Using Ruby -------------------------
    orders = Order.all.map do |order|
      order if order.user_id == @user_3.id
    end.select{|i| !i.nil?}

    average = (orders.map(&:amount).inject(:+)) / (orders.count)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(average.to_i).to eq(749)
  end

  it '21. calculates the total sales' do
    # ---------------------- Using Ruby -------------------------
    total_sales = Order.all.map(&:amount).inject(:+)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ---------------------
    # Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(total_sales).to eq(9750)
  end

  it '22. calculates the total sales for all but one user' do
    # ---------------------- Using Ruby -------------------------
    orders = Order.all.map do |order|
      order if order.user_id != @user_2.id
    end.select{|i| !i.nil?}

    total_sales = orders.map(&:amount).inject(:+)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ---------------------
    # Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(total_sales).to eq(6500)
  end

  it '23. returns all orders which include item_4' do
    expected_result = [@order_3, @order_11, @order_5, @order_13, @order_10, @order_15, @order_9]

    # ------------------ Using Ruby -------------------
    order_ids = OrderItem.where(item_id: @item_4.id).map(&:order_id)
    orders = order_ids.map { |id| Order.find(id) }
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    #  Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '24. returns all orders for user 2 which include item_4' do
    expected_result = [@order_11, @order_5]

    # ------------------ Using Ruby -------------------
    orders = Order.where(user: @user_2)
    order_ids = OrderItem.where(order_id: orders, item: @item_4).map(&:order_id)
    orders = order_ids.map { |id| Order.find(id) }
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    #  Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '25. returns items that are associated with one or more orders' do
    unordered_item = Item.create(name: 'Unordered Item')
    expected_result = [@item_1, @item_4, @item_9, @item_2, @item_5, @item_10, @item_3, @item_8, @item_7]

    # ----------------------- Using Ruby -------------------------
    items = Item.all

    ordered_items = items.map do |item|
      item if item.orders.present?
    end

    ordered_items = ordered_items.compact
    # ------------------------------------------------------------

    # ------------------ ActiveRecord Solution ----------------------
    # Solution goes here
    # ---------------------------------------------------------------

    # Expectations
    expect(ordered_items).to eq(expected_result)
    expect(ordered_items).to_not include(unordered_item)
  end

  it '26. returns the names of items that are associated with one or more orders' do
    unordered_item_1 = create(:item, name: 'Unordered Item_1')
    unordered_item_2 = create(:item, name: 'Unordered Item_2')
    unordered_item_3 = create(:item, name: 'Unordered Item_3')

    unordered_items = [unordered_item_1, unordered_item_2, unordered_item_3, @item_6.name]
    expected_result = ['Abercrombie', 'Banana Republic', 'Calvin Klein', 'Dickies', 'Eddie Bauer', 'Fox', 'Giorgio Armani', 'Izod', 'J.crew']

    # ----------------------- Using Ruby -------------------------
    items = Item.all

    ordered_items = items.map do |item|
      item if item.orders.present?
    end.compact

    ordered_items_names = ordered_items.map(&:name)
    ordered_items_names.sort
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # When you find a solution, experiment with adjusting your method chaining.
    # Which ones are you able to switch around without relying on Ruby's Enumerable methods?
    # ---------------------------------------------------------------

    # Expectations
    expect(ordered_items_names).to eq(expected_result)
    expect(ordered_items_names).to_not include(unordered_items)
  end
end
