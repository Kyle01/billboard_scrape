require_relative 'billboard_scrape'
require 'dotenv'
require "json"

Dotenv.load

file = File.open "./db.json"
data_base = JSON.load file

this_weeks_hits = BillboardScrape.new.call

hits_json = []
this_weeks_hits.each do |hit|
    hits_json.push({
        "hit_number": hit.hit_number,
        "song_title": hit.song_title,
        "artist": hit.artist,
        "momentum_symbol": hit.momentum_symbol,
        "award_info": hit.award_info,
        "last_week_position": hit.last_week_position,
        "peak_position": hit.peak_position,
        "wks_on_chart": hit.wks_on_chart
    })
end
new_data_base_entry = {
    "date": Time.now.strftime("%m/%d/%Y"),
    "hits": hits_json
}

data_base.push(new_data_base_entry)

puts data_base

File.open("./db.json","w") do |f|
    f.write(data_base.to_json)
end


# puts data