require 'rss'
require 'open-uri'

class CraigslistScraper
  def initialize(base_url)
    @base_url = base_url + '?format=rss'
  end

  # Returns price as float given xml item title, or 0 if not found
  def getPrice(title_str) 
    title_str.scan(/(\s&#x0024;)+([0-9]+)+(.[0-9]+)\s/).first
             .join.gsub('&#x0024;', '').strip! .to_f rescue 0.0
  end

  # Returns given number of results, newest first, as a hash array 
  # Each hash contains the fields `title`, `price`, and `issue_date`
  def getListings(count)
    rcount = 0
    results = []
    url_token = "" #Stores additional query tokens

    while rcount < count
      feed = RSS::Parser.parse(open(@base_url + url_token).read, false)
      feed.items.each_with_index do |item, index|
        break if index+rcount > count

        item = {
          title: item.title,
          price: getPrice(item.title),
          issue_date: item.date
        }

        results.push(item)
        rcount += 1
      end

      url_token = "&s=#{rcount}"
    end 

    return results
  end

end