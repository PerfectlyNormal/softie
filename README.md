# Softie

[![Build Status](https://travis-ci.org/PerfectlyNormal/softie.png)](https://travis-ci.org/PerfectlyNormal/softie)

Softie has troubles letting go.
It is a plugin for [MongoMapper](http://mongomapper.com/), and lets records be soft-deleted easily.

It contains the bare minimum that I use at the moment.
Softie does not add a default scope, but it does add *a* scope (configurable).
Softie does not override `#destroy`, `#delete` and other methods.

The app this was extracted from stores which `User` deleted the record in `deleted_by`. This feature is disabled by default, but can easily be enabled, and the field name and class configured.

## Installation

Add this line to your application's Gemfile:

    gem 'softie'

Or install it yourself as:

    $ gem install softie

## Configuration

Either load it into all models, or individual models:

    # add to all models
    MongoMapper::Document.plugin Softie

    # add to a specific model
    class Item
      include MongoMapper::Document
      plugin Softie
    end

Then call `softie` to configure it

    softie [options]

The supported options are as follows:

* `key`: Symbol. Defaults to `:deleted_at`
* `scope`: Symbol. Defaults to `:active`. Set to a falsy value to disable.
* `deleted_by_field`: Symbol. Defaults to `:deleted_by`
* `deleted_by_class`: Class. Defaults to `nil`. Set to a class to enable this functionality.

## Usage

Call `deleted!` on your document. This sets `deleted_at` to `Time.now.utc` and saves the document. If you are tracking who deleted it, pass it as `deleted!(by: current_user)`.

To restore a document, call `restore!`.

If you want to handle saving manually, use `deleted` and `restore`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
