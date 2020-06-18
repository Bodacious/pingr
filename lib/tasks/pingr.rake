require "dotenv/tasks"

namespace :pingr do
  require "pingr"

  desc "Request search engines crawl the sitemap again"
  task :ping => :dotenv do |t, args|
    sitemap_url = ENV.fetch('SITEMAP_URL')
    if sitemap_url.nil?
      warn("Please provide SITEMAP_URL")
      exit(1)
    else
      puts("Pinging search engines...")
      Pingr::Request.new(sitemap_url)
      puts("Done!")
    end
  end

end
