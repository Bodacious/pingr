# Pingr - Tell search engines about your sitemap changes

Pingr is a super-simple gem built for the [blogit](http://github.com/Bodacious/blogit "A Rails Blogging Engine") project.

## Installation

Add this line to your application's Gemfile:

    gem 'pingr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pingr

## Usage

From within your app (most likely a controller):

``` ruby
def ping_sitemaps
  Pingr::Request.new(my_sitemap_url) # This will ping Google and Bing
end
```

A good way to do this would be using Rails's after filters:

``` ruby
class PostsController < ActionController::Base

  after_filter :ping_sitemaps, only: [:create, :update, :destroy]

  # ...

  private

  def ping_sitemaps
    Pingr::Request.new(my_sitemap_url)
  end

end
```

You can view the [supported search engines](https://github.com/Bodacious/pingr/tree/master/lib/pingr/search_engines) and add your own by viewing the code in this directory:

https://github.com/Bodacious/pingr/tree/master/lib/pingr/search_engines

## Modes

By default, Pingr is set to **:test** mode, meaning it won't actually perform the requests. If the Rails environment is :production then the mode is set to **:live** which *will* perform requests to the search engines.

You can change this by manually setting `Pingr.mode`

``` ruby
# in config/initializers/pingr.rb
Pingr.mode = :live if Rails.env =~ /staging|production/
```

**NOTE:** Search engines may penalise or black-list you if you perform too many requests - they recommend no more than one per hour.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
