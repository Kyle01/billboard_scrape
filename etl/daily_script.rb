require_relative 'billboard_scrape'
require 'dotenv'

Dotenv.load

data = BillboardScrape.new.call
puts data