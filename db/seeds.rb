class Seed
  def self.run
    new.run
  end

  def run
    generate_users
    generate_items
    generate_orders
  end

  def generate_users
    50.times do |i|
      user = User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email
      )
      puts "User #{i}: #{user.name} - #{user.email} created!"
    end
  end

  def generate_items
    500.times do |i|
      item = Item.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image_url: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200"
      )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_orders
    offsetable_amount = User.count - 1
    100.times do |i|
      user  = User.offset(rand(0..offsetable_amount)).limit(1).first
      order = Order.create!(user_id: user.id)
      add_items(order)
      puts "Order #{i}: Order for #{user.name} created!"
    end
  end

  private

  def add_items(order)
    offsetable_amount = Item.count - 1
    10.times do |i|
      item = Item.offset(rand(0..offsetable_amount)).limit(1).first
      order.items << item
      puts "#{i}: Added item #{item.name} to order #{order.id}."
    end
  end
end

Seed.run
