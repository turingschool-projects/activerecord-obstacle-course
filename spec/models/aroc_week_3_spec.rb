require 'rails_helper'

describe 'ActiveRecord Obstacle Course, Week 3' do

# Looking for your test setup data?
# It's currently inside /spec/rails_helper.rb
# Not a very elegant solution, but works for this iteration.

# Here are the docs associated with ActiveRecord queries: http://guides.rubyonrails.org/active_record_querying.html

# ----------------------


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
    # REFACTOR
    users = Order.joins(:items).joins(:user).where("items.id = ?", @item_8.id).distinct("users.name").order("users.name").pluck("users.name")
    # ------------------------------------------------------------

    # Expectation
    expect(users).to eq(expected_result)
  end

  it '17. returns the name of items associated with a specific order' do
    expected_result = ['Abercrombie', 'Giorgio Armani', 'J.crew', 'Fox']

    # ----------------------- Using Ruby -------------------------
    # names = Order.last.items.all.map(&:name)
    # names.sort_by! { |x| x[/\d+/].to_i }
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    order_id = 15
    names = Order.find(order_id).items.select(:name).pluck(:name)
    # ------------------------------------------------------------

    # Expectation
    expect(names).to eq(expected_result)
  end

  it '18. returns the names of items for a users order' do
    expected_result = ['Giorgio Armani', 'Banana Republic', 'Izod', 'Fox']

    # ----------------------- Using Ruby -------------------------
    # items_for_user_3_third_order = []
    # grouped_orders = []
    # Order.all.each do |order|
    #   if order.items
    #     grouped_orders << order if order.user_id == @user_3.id
    #   end
    # end
    # grouped_orders.each_with_index do |order, idx|
    #   items_for_user_3_third_order = order.items.map(&:name) if idx == 2
    # end
    # ------------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    user = 3
    user_order = 3
    items_for_user_3_third_order = Order.where(user_id: user)[user_order - 1].items.pluck(:name)
    # ------------------------------------------------------------

    # Expectation
    expect(items_for_user_3_third_order).to eq(expected_result)
  end

  it '19. returns the average amount for all orders' do
    # ---------------------- Using Ruby -------------------------
    # average = (Order.all.map(&:amount).inject(:+)) / (Order.count)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    average = Order.average(:amount)
    # ------------------------------------------------------------

    # Expectation
    expect(average).to eq(650)
  end

  it '20. returns the average amount for all orders for one user' do
    # ---------------------- Using Ruby -------------------------
    # orders = Order.all.map do |order|
    #   order if order.user_id == @user_3.id
    # end.select{|i| !i.nil?}
    #
    # average = (orders.map(&:amount).inject(:+)) / (orders.count)
    # -----------------------------------------------------------

    # ------------------ Using ActiveRecord ----------------------
    user = @user_3
    average = Order.where(user_id: user.id).average(:amount).floor
    # ------------------------------------------------------------

    # Expectation
    expect(average.to_i).to eq(749)
  end
end
