require 'craigslist_scraper.rb'

DEFAULT_URL = 'https://raleigh.craigslist.org/search/apa'
DEFAULT_RES_COUNT = 1000

class ListingsController < ApplicationController
  before_action :set_url
  before_action :set_res_count

  def create 
    cs = CraigslistScraper.new(@url)

    # These processes could probably run in the background and have some AJAX callback
    # if there was a real front-end for this app
    listings = cs.getListings(@res_count)

    listings.each do |listing| 
      #Ensure no duplicate listing records are created
      Listing.create(listing) if Listing.where({
          title: listing[:title], 
          price: listing[:price],
          issue_date: listing[:issue_date]
        }).count == 0
    end

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
      price_limit: 200,
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
