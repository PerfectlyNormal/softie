# Softie

[![Build Status](https://travis-ci.org/PerfectlyNormal/softie.png)](https://travis-ci.org/PerfectlyNormal/softie)

Softie has troubles letting go.
It is a plugin for [MongoMapper](http://mongomapper.com/), and lets records be soft-deleted easily.

## Installation

Add this line to your application's Gemfile:

    gem 'softie'

Or install it yourself as:

    $ gem install softie

## Usage

Either load it into all models, or individual models:

    # add to all models
    MongoMapper::Document.plugin Softie

    # add to a specific model
    class Item
      include MongoMapper::Document
      plugin Softie
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
