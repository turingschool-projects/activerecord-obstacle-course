require 'rails_helper'

describe 'ActiveRecord Obstacle Course' do
  let(:user_1)    { User.create(name: 'Ian') }
  let(:user_2)    { User.create(name: 'Sal') }
  let(:user_3)    { User.create(name: 'Dione') }

  let(:item_1)  { Item.create(name: 'Thing 1') }
  let(:item_2)  { Item.create(name: 'Thing 2') }
  let(:item_3)  { Item.create(name: 'Thing 3') }
  let(:item_4)  { Item.create(name: 'Thing 4') }
  let(:item_5)  { Item.create(name: 'Thing 5') }
  let(:item_6)  { Item.create(name: 'Thing 6') }
  let(:item_7)  { Item.create(name: 'Thing 7') }
  let(:item_8)  { Item.create(name: 'Thing 8') }
  let(:item_9)  { Item.create(name: 'Thing 9') }
  let(:item_10) { Item.create(name: 'Thing 10') }

  let!(:order_1)  { Order.create(amount: 200, items: [item_1, item_1, item_2, item_3], user: user_1) }
  let!(:order_2)  { Order.create(amount: 300, items: [item_1, item_1, item_2, item_3], user: user_2) }
  let!(:order_3)  { Order.create(amount: 500, items: [item_2, item_3, item_4, item_5], user: user_3) }
  let!(:order_4)  { Order.create(amount: 501, items: [item_1, item_1, item_2, item_3], user: user_1) }
  let!(:order_5)  { Order.create(amount: 550, items: [item_1, item_5, item_4, item_7], user: user_2) }
  let!(:order_6)  { Order.create(amount: 580, items: [item_5, item_8, item_9, item_10], user: user_3) }
  let!(:order_7)  { Order.create(amount: 600, items: [item_1, item_5, item_7, item_9], user: user_1) }
  let!(:order_8)  { Order.create(amount: 700, items: [item_2, item_3, item_8, item_9], user: user_2) }
  let!(:order_9)  { Order.create(amount: 649, items: [item_3, item_4, item_8, item_10], user: user_3) }
  let!(:order_10) { Order.create(amount: 750, items: [item_1, item_5, item_4, item_7], user: user_1) }
  let!(:order_11) { Order.create(amount: 800, items: [item_5, item_4, item_7, item_9], user: user_2) }
  let!(:order_12) { Order.create(amount: 850, items: [item_1, item_3, item_7, item_10], user: user_3) }
  let!(:order_13) { Order.create(amount: 870, items: [item_2, item_3, item_4, item_7], user: user_1) }
  let!(:order_14) { Order.create(amount: 900, items: [item_3, item_5, item_8, item_9], user: user_2) }
  let!(:order_15) { Order.create(amount: 1000, items: [item_1, item_4, item_5, item_7], user: user_3) }


  ### Here are the docs associated with this lesson: http://guides.rubyonrails.org/active_record_querying.html

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
    # ------------------------------------------------------------

    # Expectation
    expect(order_id).to eq(order_1.id)
  end

  it '3. finds order id of largest order' do
    # ----------------------- Using Raw SQL ----------------------
    order_id = ActiveRecord::Base.connection.execute('SELECT id FROM orders ORDER BY amount DESC LIMIT 1').first['id']
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(order_id).to eq(order_15.id)
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
    ids = [item_1.id, item_2.id, item_4.id]

    # ----------------------- Using Ruby -------------------------
    items = Item.all.select { |item| ids.include?(item.id) }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(items).to eq([item_1, item_2, item_4])
  end

  it '6. finds multiple orders by id' do
    ids = [order_1.id, order_3.id, order_5.id, order_7.id]
    expected_result = [order_1, order_3, order_5, order_7]

    # ----------------------- Using Ruby -------------------------
    orders = Order.all.select { |order| ids.include?(order.id) }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '7. finds orders with an amount between 700 and 1000' do
    expected_result = [order_8, order_10, order_11, order_12, order_13, order_14, order_15]

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
    expected_result = [order_1, order_2, order_3, order_4]

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
    expected_result = [order_3, order_6, order_9, order_12, order_15]

    # ----------------------- Using Ruby -------------------------
    orders_of_user_3 = Order.all.select { |order| order.user_id == 3 }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders_of_user_3).to eq(expected_result)
  end

  it '10. sorts the orders from most expensive to least expensive' do
    expected_result = [order_15, order_14, order_13, order_12, order_11, order_10, order_8, order_9, order_7, order_6, order_5, order_4, order_3, order_2, order_1]

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
    expected_result = [order_1, order_2, order_3, order_4, order_5, order_6, order_7, order_9, order_8, order_10, order_11, order_12, order_13, order_14, order_15]

    # ----------------------- Using Ruby -------------------------
    orders = Order.all.sort_by { |order| order.amount }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '12. should return all items except items: 3, 4 & 5' do
    items_not_included = [item_3, item_4, item_5]
    expected_result = [item_1, item_2, item_7, item_8, item_9, item_10]

    # ----------------------- Using Ruby -------------------------
    items = Item.all.map { |item| item unless items_not_included.include?(item) }.compact
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(items).to eq(expected_result)
  end

  it "13. groups an order's items by name" do
    expected_result = [item_2, item_3, item_4, item_5]

    # ----------------------- Using Ruby -------------------------
    order = Order.find(3)
    grouped_items = order.items.sort_by { |item| item.name }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(grouped_items).to eq(expected_result)
  end

  it '14. plucks all values from one column' do
    expected_result = ['Thing 1', 'Thing 2', 'Thing 3', 'Thing 4', 'Thing 5', 'Thing 7', 'Thing 8', 'Thing 9', 'Thing 10']

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
    expected_result = ['Thing 1', 'Thing 2', 'Thing 3', 'Thing 1',
                       'Thing 1', 'Thing 2', 'Thing 3', 'Thing 1',
                       'Thing 2', 'Thing 3', 'Thing 4', 'Thing 5',
                       'Thing 1', 'Thing 2', 'Thing 3', 'Thing 1',
                       'Thing 1', 'Thing 5', 'Thing 4', 'Thing 7',
                       'Thing 5', 'Thing 8', 'Thing 9', 'Thing 10',
                       'Thing 1', 'Thing 5', 'Thing 7', 'Thing 9',
                       'Thing 2', 'Thing 3', 'Thing 8', 'Thing 9',
                       'Thing 3', 'Thing 4', 'Thing 8', 'Thing 10',
                       'Thing 1', 'Thing 5', 'Thing 4', 'Thing 7',
                       'Thing 5', 'Thing 4', 'Thing 7', 'Thing 9',
                       'Thing 1', 'Thing 3', 'Thing 7', 'Thing 10',
                       'Thing 2', 'Thing 3', 'Thing 4', 'Thing 7',
                       'Thing 3', 'Thing 5', 'Thing 8', 'Thing 9',
                       'Thing 1', 'Thing 4', 'Thing 5', 'Thing 7']

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
    expect(names).to eq(expected_result)
  end

  it '16. returns the names of users who ordered one specific item' do
    expected_result = [user_3.name, user_2.name]

    # ----------------------- Using Raw SQL-----------------------
    users = ActiveRecord::Base.connection.execute("
      select
        distinct users.name
      from users
        join orders on orders.user_id=users.id
        join order_items ON order_items.order_id=orders.id
      where order_items.item_id=#{item_8.id}
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
    expected_result = ['Thing 1', 'Thing 4', 'Thing 5', 'Thing 7']

    # ----------------------- Using Ruby -------------------------
    names = Order.last.items.all.map(&:name)
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(names).to eq(expected_result)
  end

  it '18. returns the sorted names of items for a user order' do
    expected_result = ['Thing 3', 'Thing 4', 'Thing 8', 'Thing 10']

    # ----------------------- Using Ruby -------------------------
    items_for_user_3_third_order = []
    grouped_orders = []
    Order.all.each do |order|
      if order.items
        grouped_orders << order if order.user_id == 3
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
    expect(items_for_user_3_third_order).to eq(expected_result)
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
      order if order.user_id == 3
    end.select{|i| !i.nil?}

    average = (orders.map(&:amount).inject(:+)) / (orders.count)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    # Solution goes here
    # ------------------------------------------------------------

    # Expectation
    expect(average.to_i).to eq(715)
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
      order if order.user_id != 2
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
    expected_result = [order_3, order_5, order_9, order_10, order_11, order_13, order_15]

    # ------------------ Inefficient Solution -------------------
    order_ids = OrderItem.where(item_id: item_4.id).map(&:order_id)
    orders = order_ids.map { |id| Order.find(id) }
    # -----------------------------------------------------------

    # ------------------ Improved Solution ----------------------
    #  Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '24. returns all orders for user 2 which include item_4' do
    expected_result = [order_5, order_11]

    # ------------------ Inefficient Solution -------------------
    orders = Order.where(user_id: user_2)
    order_ids = OrderItem.where(order_id: orders, item_id: item_4.id).map(&:order_id)
    orders = order_ids.map { |id| Order.find(id) }
    # -----------------------------------------------------------

    # ------------------ Improved Solution ----------------------
    #  Solution goes here
    # -----------------------------------------------------------

    # Expectation
    expect(orders).to eq(expected_result)
  end

  it '25. returns items that are associated with one or more orders' do
    unordered_item = Item.create(name: 'Unordered Item')
    expected_result = [item_1, item_2, item_3, item_4, item_5, item_7, item_8, item_9, item_10]

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
    unordered_item_1 = Item.create(name: 'Unordered Item_1')
    unordered_item_2 = Item.create(name: 'Unordered Item2_')
    unordered_item_3 = Item.create(name: 'Unordered Item_3')

    unordered_items = [unordered_item_1, unordered_item_2, unordered_item_3]
    expected_result = ['Thing 1', 'Thing 2', 'Thing 3', 'Thing 4', 'Thing 5', 'Thing 7', 'Thing 8', 'Thing 9', 'Thing 10']

    # ----------------------- Using Ruby -------------------------
    items = Item.all

    ordered_items = items.map do |item|
      item if item.orders.present?
    end.compact

    ordered_items_names = ordered_items.map(&:name)
    # ------------------------------------------------------------

    # ------------------ ActiveRecord Solution ----------------------
    # Solution goes here
    # When you find a solution, experiment with adjusting your method chaining
    # Which ones are you able to switch around without relying on Ruby's Enumerable methods?
    # ---------------------------------------------------------------

    # Expectations
    expect(ordered_items_names).to eq(expected_result)
    expect(ordered_items_names).to_not include(unordered_items)
  end

  xit '27. returns a table of information for all users orders' do
    custom_results = [user_3, user_1, user_2]

    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # --------------------------------------------------------------------------
    # user.name  |  total_order_count
    # Dione      |         5
    # Ian        |         5
    # Sal        |         5

    # ------------------ ActiveRecord Solution ----------------------
    # custom_results =
    # ---------------------------------------------------------------

    expect(custom_results[0].name).to eq(user_3.name)
    expect(custom_results[0].total_order_count).to eq(5)
    expect(custom_results[1].name).to eq(user_1.name)
    expect(custom_results[1].total_order_count).to eq(5)
    expect(custom_results[2].name).to eq(user_2.name)
    expect(custom_results[2].total_order_count).to eq(5)
  end

  xit '28. returns a table of information for all users items' do
    custom_results = [user_2, user_1, user_3]

    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # --------------------------------------------------------------------------
    # user.name  |  total_item_count
    # Sal        |         20
    # Ian        |         20
    # Dione      |         20

    # ------------------ ActiveRecord Solution ----------------------
    # custom_results =
    # ---------------------------------------------------------------

    expect(custom_results[0].name).to eq(user_2.name)
    expect(custom_results[0].total_item_count).to eq(20)
    expect(custom_results[1].name).to eq(user_1.name)
    expect(custom_results[1].total_item_count).to eq(20)
    expect(custom_results[2].name).to eq(user_3.name)
    expect(custom_results[2].total_item_count).to eq(20)
  end

  xit '29. returns a table of information for all users orders and item counts' do
    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # --------------------------------------------------------------------------
    # user_name  |  order_id  |  item_count  |
    # Sal        |  2         |  4           |
    # Sal        |  5         |  4           |
    # Sal        |  8         |  4           |
    # Sal        |  11        |  4           |
    # Sal        |  14        |  4           |
    # Ian        |  1         |  4           |
    # Ian        |  4         |  4           |
    # Ian        |  7         |  4           |
    # Ian        |  10        |  4           |
    # Ian        |  13        |  4           |
    # Dione      |  3         |  4           |
    # Dione      |  6         |  4           |
    # Dione      |  9         |  4           |
    # Dione      |  12        |  4           |
    # Dione      |  15        |  4           |

    # the raw SQL to produce this table would look like the following:
    # ActiveRecord::Base.connection.execute('select
    #   users.name as user_name,
    #   orders.id as order_id,
    #   count(order_items.id) as item_count
    # from users
    #   join orders on orders.user_id=users.id
    #   join order_items on order_items.order_id=orders.id
    # group by users.name, orders.id
    # order by users.name desc')
    #
    # how will you turn this into the proper ActiveRecord commands?

    # ------------------ ActiveRecord Solution ----------------------
    # data = []
    # ---------------------------------------------------------------


    expect(data[0].user_name).to eq(user_2.name)
    expect(data[0].order_id).to eq(2)
    expect(data[0].item_count).to eq(4)
    expect(data[5].user_name).to eq(user_1.name)
    expect(data[5].order_id).to eq(1)
    expect(data[5].item_count).to eq(4)
    expect(data[12].user_name).to eq(user_3.name)
    expect(data[12].order_id).to eq(9)
    expect(data[12].item_count).to eq(4)
  end

  xit '30. returns the names of items that have been ordered without n+1 queries' do
    # What is an n+1 query?
    # This video is older, but the concepts explained are still relevant:
    # http://railscasts.com/episodes/372-bullet

    # Don't worry about the lines containing Bullet. This is how we are detecting n+1 queries.
    Bullet.enable = true
    Bullet.raise = true
    Bullet.start_request

    # ------------------------------------------------------
    orders = Order.all # Edit only this line
    # ------------------------------------------------------

    # Do not edit below this line
    orders.each do |order|
      order.items.each do |item|
        item.name
      end
    end

    # Don't worry about the lines containing Bullet. This is how we are detecting n+1 queries.
    Bullet.perform_out_of_channel_notifications
    Bullet.end_request
  end
end
