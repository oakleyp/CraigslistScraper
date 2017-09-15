require 'craigslist_scraper.rb'

DEFAULT_URL = 'https://raleigh.craigslist.org/search/apa'
DEFAULT_RES_COUNT = 1000

class ListingsController < ApplicationController
  before_action :set_url
  before_action :set_res_count

  def create 
    cs = CraigslistScraper.new(@url)

    # If this had a real front end, the scraping and saving process
    # could run in the background and have some AJAX callback
    # function render the results when they're done processing
    listings = cs.getListings(@res_count)

    listings.each { |listing| Listing.create(listing) }

    redirect_to root_path
  end

  def index
    @listings = Listing.all
    @tables = layout_tables
  end

  private # Leaving room for the possibility that these will be set by query params

  def set_url
    @url = DEFAULT_URL
  end

  def set_res_count 
    @res_count = DEFAULT_RES_COUNT
  end

  #Create objects for tables of each different price range in defined increments
  def layout_tables
    listings = @listings.sort { |a, b| a.price <=> b.price } 
    increment = 200
    inc_count = 1

    results = [{
      price_limit: increment,
      listings: []
    }]

    listings.each do |listing|
      if listing.price <= increment*inc_count
        results[results.count-1][:listings].push(listing)
      else 
        inc_count += 1 while increment*inc_count < listing.price
        results.push({
          price_limit: increment*inc_count,
          listings: [listing]
        })
      end
    end

    #Trim off first result item if there are no listings <= $200
    results = results.shift if(results[0][:listings].count == 0 && results.count > 1)

    return results
  end

end
