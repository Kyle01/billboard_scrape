require "nokogiri"
require "open-uri"
require "ostruct"

class BillboardScrape 

    def initialize 
        billboard_url = 'https://www.billboard.com/charts/hot-100/'
        doc = Nokogiri::HTML(URI.open(billboard_url))
        
        @billboard_rows = doc.xpath("//*[contains(concat(' ', normalize-space(@class), ' '), ' #{'o-chart-results-list-row'} ')]")
        @date = Date.today
    end

    def call
        solution = []
        @billboard_rows.each_with_index do |billboard_row, i|
            hit_data = OpenStruct.new
            hit_data.hit_number = i + 1
            hit_data.song_title = billboard_row.css('h3').text.lstrip.strip
            hit_data.momentum_symbol = arrow_shape(billboard_row)
            hit_data.award_info = award_info(billboard_row)
            
            if billboard_row.css('span')[1].text.lstrip.strip.include?('NEW') || billboard_row.css('span')[1].text.lstrip.strip.include?('ENTRY')
                hit_data.artist = billboard_row.css('span')[3].text.lstrip.strip
                hit_data.last_week_position = billboard_row.css('span')[4].text.lstrip.strip
                hit_data.peak_position = billboard_row.css('span')[5].text.lstrip.strip
                hit_data.wks_on_chart = billboard_row.css('span')[6].text.lstrip.strip
            else 
                hit_data.artist = billboard_row.css('span')[1].text.lstrip.strip
                hit_data.last_week_position = billboard_row.css('span')[2].text.lstrip.strip
                hit_data.peak_position = billboard_row.css('span')[3].text.lstrip.strip
                hit_data.wks_on_chart = billboard_row.css('span')[4].text.lstrip.strip
            end
        
            solution << hit_data
        end
        solution
    end

    private 

    def arrow_shape(element)
        arrow_color = element.css('svg')[0].child.attribute('fill')
        return 'UP' if arrow_color.to_s =='#00dda1'
        return 'DOWN' if arrow_color.to_s =='#fb676b'
        return 'SIDEWAYS' if arrow_color.to_s =='#8289a1'
        
        return 'RE-ENTRY' if element.css('span')[1].text.lstrip.strip.include?('ENTRY')
        return 'NEW' if element.css('span')[1].text.lstrip.strip.include?('NEW')
    
        nil
    end

    # TO DO: implement this
    def award_info(element)
        nil
    end
end

