require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 5' do

# Looking for your test setup data?
# It's currently inside /spec/rails_helper.rb
# Not a very elegant solution, but works for this iteration.

# Here are the docs associated with ActiveRecord queries: http://guides.rubyonrails.org/active_record_querying.html

# ----------------------


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
    custom_results = [@user_3, @user_1, @user_2]

    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # --------------------------------------------------------------------------
    # users.name     |  total_order_count
    # Mugatu         |         4
    # Hansel         |         5
    # Zoolander      |         6

    # ------------------ ActiveRecord Solution ----------------------
    custom_results = []
    # ---------------------------------------------------------------

    expect(custom_results[0].name).to eq(@user_3.name)
    expect(custom_results[0].total_order_count).to eq(4)
    expect(custom_results[1].name).to eq(@user_2.name)
    expect(custom_results[1].total_order_count).to eq(5)
    expect(custom_results[2].name).to eq(@user_1.name)
    expect(custom_results[2].total_order_count).to eq(6)
  end

  xit '28. returns a table of information for all users items' do
    custom_results = [@user_2, @user_3, @user_1]

    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # --------------------------------------------------------------------------
    # users.name      |  total_item_count
    # Hansel          |         20
    # Mugatu          |         16
    # Zoolander       |         24

    # ------------------ ActiveRecord Solution ----------------------
    custom_results = []
    # ---------------------------------------------------------------

    expect(custom_results[0].name).to eq(@user_2.name)
    expect(custom_results[0].total_item_count).to eq(20)
    expect(custom_results[1].name).to eq(@user_3.name)
    expect(custom_results[1].total_item_count).to eq(16)
    expect(custom_results[2].name).to eq(@user_1.name)
    expect(custom_results[2].total_item_count).to eq(24)
  end

  xit '29. returns a table of information for all users orders and item counts' do
    # using a single ActiveRecord call, fetch a joined object that mimics the
    # following table of information:
    # ---------------------------------------
    # user_name  | order_id  | avg_item_cost
    # Zoolander      | 5         | 50
    # Zoolander      | 11        | 125
    # Zoolander      | 8         | 145
    # Zoolander      | 14        | 150
    # Zoolander      | 9         | 187
    # Zoolander      | 6         | 217
    # Mugatu         | 1         | 125
    # Mugatu         | 12        | 162
    # Mugatu         | 15        | 212
    # Mugatu         | 10        | 250
    # Hansel         | 4         | 75
    # Hansel         | 3         | 137
    # Hansel         | 7         | 175
    # Hansel         | 2         | 200
    # Hansel         | 13        | 225

    # the raw SQL to produce this table would look like the following:
    # select
    #   users.name as user_name,
    #   orders.id as order_id,
    #   orders.amount / count(order_items.id) as avg_item_cost
    # from users
    #   join orders on orders.user_id=users.id
    #   join order_items on order_items.order_id=orders.id
    # group by users.name, orders.id
    # order by user_name desc, avg_item_cost asc
    #
    # how will you turn this into the proper ActiveRecord commands?

    # ------------------ ActiveRecord Solution ----------------------
    data = []
    # ---------------------------------------------------------------

    expect([data[0].user_name,data[0].order_id,data[0].avg_item_cost]).to eq([@user_1.name, @order_1.id, 50])
    expect([data[1].user_name,data[1].order_id,data[1].avg_item_cost]).to eq([@user_1.name, @order_4.id, 125])
    expect([data[2].user_name,data[2].order_id,data[2].avg_item_cost]).to eq([@user_1.name, @order_6.id, 145])
    expect([data[3].user_name,data[3].order_id,data[3].avg_item_cost]).to eq([@user_1.name, @order_7.id, 150])
    expect([data[4].user_name,data[4].order_id,data[4].avg_item_cost]).to eq([@user_1.name, @order_10.id, 187])
    expect([data[5].user_name,data[5].order_id,data[5].avg_item_cost]).to eq([@user_1.name, @order_13.id, 217])
    expect([data[6].user_name,data[6].order_id,data[6].avg_item_cost]).to eq([@user_3.name, @order_3.id, 125])
    expect([data[7].user_name,data[7].order_id,data[7].avg_item_cost]).to eq([@user_3.name, @order_9.id, 162])
    expect([data[8].user_name,data[8].order_id,data[8].avg_item_cost]).to eq([@user_3.name, @order_12.id, 212])
    expect([data[9].user_name,data[9].order_id,data[9].avg_item_cost]).to eq([@user_3.name, @order_15.id, 250])
    expect([data[10].user_name,data[10].order_id,data[10].avg_item_cost]).to eq([@user_2.name, @order_2.id, 75])
    expect([data[11].user_name,data[11].order_id,data[11].avg_item_cost]).to eq([@user_2.name, @order_5.id, 137])
    expect([data[12].user_name,data[12].order_id,data[12].avg_item_cost]).to eq([@user_2.name, @order_8.id, 175])
    expect([data[13].user_name,data[13].order_id,data[13].avg_item_cost]).to eq([@user_2.name, @order_11.id, 200])
    expect([data[14].user_name,data[14].order_id,data[14].avg_item_cost]).to eq([@user_2.name, @order_14.id, 225])
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
