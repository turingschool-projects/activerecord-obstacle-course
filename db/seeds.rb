include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

# # DO NOT CHANGE THE ORDER OF THIS DATA TO MAKE TESTS PASS
@user_1 = create(:user, name: 'Zoolander')
@user_2 = create(:user, name: 'Hansel')
@user_3 = create(:user, name: 'Mugatu')

# # DO NOT CHANGE THE ORDER OF THIS DATA TO MAKE TESTS PASS
@item_1  = create(:item, name: 'Abercrombie')
@item_4  = create(:item, name: 'Banana Republic')
@item_9  = create(:item, name: 'Calvin Klein')
@item_2  = create(:item, name: 'Dickies')
@item_5  = create(:item, name: 'Eddie Bauer')
@item_10 = create(:item, name: 'Fox')
@item_3  = create(:item, name: 'Giorgio Armani')
@item_6  = create(:item, name: 'Hurley')
@item_8  = create(:item, name: 'Izod')
@item_7  = create(:item, name: 'J.crew')

# DO NOT CHANGE THE ORDER OF THIS DATA TO MAKE TESTS PASS
@order_3 = create(:order, amount: 500, items: [@item_2, @item_3, @item_4, @item_5], user: @user_3)
@order_11 = create(:order, amount: 800, items: [@item_5, @item_4, @item_7, @item_9], user: @user_2)
@order_5 = create(:order, amount: 550, items: [@item_1, @item_5, @item_4, @item_7], user: @user_2)
@order_2 = create(:order, amount: 300, items: [@item_1, @item_1, @item_2, @item_3], user: @user_2)
@order_1 = create(:order, amount: 200, items: [@item_1, @item_1, @item_2, @item_3], user: @user_1)
@order_13 = create(:order, amount: 870, items: [@item_2, @item_3, @item_4, @item_7], user: @user_1)
@order_8 = create(:order, amount: 700, items: [@item_2, @item_3, @item_8, @item_9], user: @user_2)
@order_6 = create(:order, amount: 580, items: [@item_5, @item_8, @item_9, @item_10], user: @user_1)
@order_10 = create(:order, amount: 750, items: [@item_1, @item_5, @item_4, @item_7], user: @user_1)
@order_15 = create(:order, amount: 1000, items: [@item_1, @item_4, @item_5, @item_7], user: @user_3)
@order_4 = create(:order, amount: 501, items: [@item_1, @item_1, @item_2, @item_3], user: @user_1)
@order_9 = create(:order, amount: 649, items: [@item_3, @item_4, @item_8, @item_10], user: @user_3)
@order_14 = create(:order, amount: 900, items: [@item_3, @item_5, @item_8, @item_9], user: @user_2)
@order_7 = create(:order, amount: 600, items: [@item_1, @item_5, @item_7, @item_9], user: @user_1)
@order_12 = create(:order, amount: 850, items: [@item_1, @item_3, @item_7, @item_10], user: @user_3)
