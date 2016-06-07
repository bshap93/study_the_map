#CLI controller 
require "./lib/study_the_map.rb"
class StudyTheMap::CLI

  def call
    get_areas
    goodbye
  end

  def get_map
    while resort_name != 'back'
      puts "1. Please enter the name of the ski area you would like the map for:"
      puts "2. Or type 'back' to go back to the main menu."
      resort_name = gets.strip
      if resort_name == 'back'
        get_areas
      elsif Region.ski_area_list.include?(resort_name)
        SkiMaps.new(resort_name)
      else
        puts "Invalid ski area name"
      end
    end
  end

  def get_areas
    input = nil
    while input != 'exit'
      puts "Select a region (type 'region') or Ski Resort (type 'resort') to study associated ski trail maps!"
      puts '-----------------------------------------------------------------------'
      puts "Or check out the world map to find resorts and trails: (type 'world')"
      puts '-----------------------------------------------------------------------'
      puts "Enter the area you would like to search:"
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
        "Please enter 'region', 'resort', or 'world'"
      end
    end
  end

  def region
    region = nil
    while region != "back"
      puts "-----------------------------------------------------------------------"
      puts "1. Input a region for a list of ski resorts, or"
      puts "2. Request a list of regions by typing the letter the region you're looking for starts with,"
      puts "3. Or 'back' to return to the main menu."
      region = gets.strip
      if region.size == 1
        Region.starts_with(region)
        region
      else
        begin
          region_object = Region.new(region)
          region_object.full_list
        rescue Exception
          if region != "back"
            puts "Not a valid region."
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