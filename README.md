# Pingr - Tell search engines about your sitemap changes

Pingr is a super-simple gem built for the [blogit](http://github.com/KatanaCode/blogit "A Rails Blogging Engine") project.

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
  Pingr::Request.new(:google, my_sitemap_url).ping
end
```

A good way to do this would be using Rails's after filters:

``` ruby
class PostsController < ActionController::Base

  after_filter :ping_sitemaps, only: [:create, :update, :destroy]
  
  # ... 
  
  private
  
  def ping_sitemaps
    Pingr::Request.new(:google, my_sitemap_url).ping
    Pingr::Request.new(:bing, my_sitemap_url).ping
  end
  
end
```

You can ping all [supported search engines](https://github.com/KatanaCode/pingr/blob/master/lib/pingr.rb#L9) by doing:

``` ruby
def ping_sitemaps
  for search_engine in Pingr::SUPPORTED_SEARCH_ENGINES
    Pingr::Request.new(search_engine, my_sitemap_url).ping
  end
end
```

... not the most elegant solution but we'll improve that in future versions.

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
