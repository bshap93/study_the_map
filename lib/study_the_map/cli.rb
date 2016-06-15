#CLI controller 
class StudyTheMap::CLI

  def call

    get_areas

    goodbye

  end

  def list_map_years  

    @skimaps.area_info.scrape_map_data.each do |map|
      puts map.search("yearPublished").text
    end

  end

  def get_map

    resort_name = nil
    while resort_name != 'back'

      puts "1. Please enter the name of the ski area you would like the map for:"
      puts '-----------------------------------------------------------------------'
      puts "2. Or type 'back' to go back to the main menu."
      puts '-->'

      resort_name = gets.strip

      if resort_name == 'back'

        get_areas

      elsif Region.ski_area_list.include?(resort_name)

        @skimaps = SkiMaps.new(resort_name)
        self.map_count_and_pick(@skimaps.map_count)


      else

        puts "Invalid ski area name"
      end
    end
  end

  def map_count_and_pick(map_count)

    puts "There are #{map_count} maps for this ski area."

    if map_count == "0"

      StudyTheMap::CLI.new.call

    elsif map_count == "1"

      self.pick_map(self.get_map_years.join)

    else

      puts "Please wait while we fetch the maps' years..."
      puts ""

      self.list_map_years
      map_years = @skimaps.area_info.scrape_map_years

      input = nil

      until map_years.include?(input)
        puts ""
        puts "Please pick a year that is listed."
        input = gets.strip
      end

      pick_map(input)

    end

  end

  def pick_map(year)

    map_data = @skimaps.area_info.scrape_map_data.detect do |map|
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



  def get_areas
    
    input = nil
    while input != 'exit'

      puts "1. Select a region (type 'region') or Ski Resort (type 'resort') to study associated ski trail maps!"
      puts '-----------------------------------------------------------------------'
      puts "2. Or check out the world map to find resorts and trails: (type 'world')"
      puts '-----------------------------------------------------------------------'
      puts "3. Enter the area you would like to search:"
      puts '-->'
      
      input = gets.strip.downcase

      case input
      when "region"

        region

      when "world"

        Launchy.open("http://openskimap.org/")

      when "resort"

        get_map

      else 

        puts "Please enter 'region', 'resort', or 'world'"
        puts '-----------------------------------------------------------------------'
      end
    end
  end

  def region

    region_name = nil
    while region_name != "back"

      puts "-----------------------------------------------------------------------"
      puts "1. Input a region for a list of ski resorts, or"
      puts '-----------------------------------------------------------------------'
      puts "2. Request a list of regions by typing the letter the region you're looking for starts with,"
      puts '-----------------------------------------------------------------------'
      puts "3. Or 'back' to return to the main menu."
      puts '-->'
      
      region_name = gets.strip

      if region_name == "back"
        call
      end
      
      if region_name.size == 1

        Region.starts_with(region_name)
        region

      else

        begin

          region_object = Region.new(region_name)
          region_object.full_list

        rescue Exception

          if region_name != "back"
            puts '-----------------------------------------------------------------------'
            puts "Not a valid region."
            puts '-----------------------------------------------------------------------'
          end

          region

        end      
      end
    end
  end

  def goodbye

    puts "Come back anytime for more maps!"
  end
end