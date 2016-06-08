require './lib/study_the_map.rb'

class SkiMaps

  attr_accessor :area_name, :area_info

  def initialize(area_name)

    @area_name = area_name
    area_doc = Nokogiri::XML(open("https://skimap.org/SkiAreas/view/#{LookupIDS.find_ski_area_id(area_name)}.xml"))
    
    @area_info = area_doc
    map_count = area_doc.search("skiMaps").attr('count').text

    puts "There are #{map_count} maps for this ski area."

    if map_count == "0"

      StudyTheMap::CLI.new.call

    elsif map_count == "1"

      self.pick_map(self.get_map_years.join)

    else

      puts "Please wait while we fetch the maps' years..."
      puts ""

      self.list_map_years
      map_years = self.get_map_years

      input = nil

      until map_years.include?(input)
        puts ""
        puts "Please pick a year that is listed."
        input = gets.strip
      end

      self.pick_map(input)

    end
  end

  def get_map_ids

    id_array = []

    @area_info.search("skiMaps skiMap").each do |map|
      id_array << map.attr('id')
    end

    id_array

  end

  def get_map_data

    map_data_array = []

    self.get_map_ids.each do |id|
      map_data_array << Nokogiri::XML(open("https://skimap.org/SkiMaps/view/#{id}.xml"))
    end

    map_data_array

  end

  def list_map_years  

    self.get_map_data.each do |map|
      puts map.search("yearPublished").text
    end

  end

  def get_map_years

    map_years_array = []

    self.get_map_data.each do |map|
      map_years_array << map.search("yearPublished").text
    end

    map_years_array

  end

  def pick_map(year)

    map_data = self.get_map_data.detect do |map|
      map.search("yearPublished").text == year
    end

    begin
      url = map_data.search("render").attr('url').text
    rescue Exception
      url = map_data.search("unprocessed").attr('url').text
    end

    puts "Would you like to download the Map to your working directory or see it in your browser?"
    puts "Type 'browser', 'download', or 'exit'"

    input = gets.strip

    case input 
      
    when "download"

      exec "curl -O #{url}"
      puts "Enjoy your map!"

    when "browser"

      Launchy.open("#{url}")
      puts "Enjoy your map!"

    end

  end
end
