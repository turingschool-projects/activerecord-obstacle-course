## Storedom

Storedom is a simplistic e-commerce application used for various lessons and tutorials at Turing.

### Setup

To get set up with the storedom application, clone it
via `git` and pull in gem dependencies with `bundler`:

```sh
$ git clone https://github.com/turingschool-examples/storedom.git
$ cd storedom
$ bundle update
```

And set up the database and included seed records:

```
bundle exec rake db:{create,setup}
```
