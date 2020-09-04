# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:each) do
    # The items and orders above were created out of order *ON PURPOSE* -- there are many ways to solve
    # these problems, but we found that students were writing incorrect queries that still passed because
    # they were relying on the order that these things were created.
    #
    # If you attempt to re-order these objects, many (or all) of the tests will not function correctly
    # and you will be asked to start over.
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
  end

  config.after(:each) do
    FactoryBot.reload
  end
  config.include FactoryBot::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
