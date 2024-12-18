# Goals

We've gotten fairly familiar with ActiveRecord's most common methods. Let's make sure we don't get rusty with those other less-frequently used methods.

The first few portions of this obstacle course are meant to test your knowledge around processing things in Ruby to put more of that work on the database (PostgreSQL) to make our own code easier to maintain. Your job will be to remove the code that processes data in Ruby, and replace that code with proper ActiveRecord commands to do the exact same work.

**There will be more than one way to solve some of these problems.** If you want feedback on your approach, please tag your instructors on GitHub for a code review.

The remaining portions of the obstacle course will increase in difficulty and will teach you how to turn raw SQL into proper ActiveRecord commands.

## Instructions

1. Fork [the repo](https://github.com/turingschool-projects/activerecord-obstacle-course) to your own GitHub account, then clone down your fork.

2. Do the usual setup for a Rails app:

```bash
bundle install
bundle update
rails db:{drop,create,migrate,seed} # seeding will take a few moments
bundle exec rspec spec/aroc
# you should see several passing tests, and a few skipped tests
```

*SETUP NOTES:*
If you run into bundle issues then delete the `Gemfile.lock` and then run `bundle install`. 

If you see an error similar to `ERROR: relation "order_items" does not exist`, that likely means that the `rails db:migrate` command did not migrate the test database. If so, you can fix this by running:

```bash
rails db:migrate RAILS_ENV=test
```

3. **You must not change the setup or expectations of any test.**

4. Start with the top test within `spec/aroc/aroc_week_#_spec.rb` and work in order.

5. To run your tests, you can run `bundle exec rspec spec/aroc/aroc_week_#_spec.rb`

6. If you want to run one specific test, you can run `bundle exec rspec spec/aroc/aroc_week_#_spec.rb:LINE_NUMBER`.

    * For example: `bundle exec rspec spec/aroc/aroc_week_3_spec.rb:22`

7. Most of the tests follow the same format...

    * Comment out the original ruby code -- don't erase it completely.

      ```ruby

      # -----------------------------
      # A section with some Ruby code
      # -----------------------------

      ```

    * Write a refactored implementation using ActiveRecord. Assign to the same variables as above.

      ```ruby
      # -----------------------------
      # A section for you to write refactor the Ruby or raw SQL code
      # -----------------------------
      ```

    * Leave the expectations alone. They will determine whether you have a working solution.

      ```ruby
      # -----------------------------
      # The expectation
      # -----------------------------
      ```

## Solutions / Extra Help

If you wish, compare your answers to the ones we came up with in `answers` branch of this repo.

There are [walkthrough videos](https://drive.google.com/drive/folders/18etfJOBPZoDvCNbWZg67E35GMZUwJiWT) available that may help you think through how we came up with these solutions. Again, **there may be more than one way to solve these problems** so even if your solution doesn't match ours, if it passes the test, it's probably great! Feel free to ask your instructors to double-check your work.

**NOTE:** This repo has be reorganized for the SE program so the video weeks may not correspond to the weeks in the repo. Our advice is to use the test number when trying to find the video walkthrough for a solution.

* **AROC Week 1** has solutions for tests 1 - 8
* **AROC Week 2** has solutions for tests 9 - 15
* **AROC Week 3** has solutions for tests 16 - 20
* **AROC Week 4** has solutions for tests 21 - 25
* **AROC Week 5** has solutions for tests 26 - 30

## Extensions

If you finish everything in here, you're welcome to take on the following extensions:

* Break your solutions into scopes and/or class methods.
* Try to implement one example using ActiveRecord's `merge`.
