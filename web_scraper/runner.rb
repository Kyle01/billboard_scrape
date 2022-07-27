require "nokogiri"
require "open-uri"
require "ostruct"

today = Date.today
billboard_url = 'https://www.billboard.com/charts/hot-100/'

html = URI.open(billboard_url)
doc = Nokogiri::HTML(html)
billboard_rows = doc.xpath("//*[contains(concat(' ', normalize-space(@class), ' '), ' #{'o-chart-results-list-row'} ')]")

billboard_rows.each_with_index do |billboard_row, i|
    hit_data = OpenStruct.new
    hit_data.hit_number = i + 1
    hit_data.song_title = billboard_row.css('h3').text.lstrip.strip
    hit_data.artist = billboard_row.css('span')[1].text.lstrip.strip
    hit_data.last_week_position = billboard_row.css('span')[2].text.lstrip.strip
    hit_data.peak_position = billboard_row.css('span')[3].text.lstrip.strip
    hit_data.wks_on_chart = billboard_row.css('span')[4].text.lstrip.strip
    hit_data.arrow_detail = nil
    hit_data.award_info = nil

    puts hit_data
end