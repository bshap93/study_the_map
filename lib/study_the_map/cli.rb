#CLI controller 
require "./lib/study_the_map.rb"
class StudyTheMap::CLI

  def call
    get_areas
    goodbye
  end

  def get_map
    puts "Please enter the name of the ski area you would like the map for:"
    resort_name = gets.strip
    SkiMaps.new(resort_name)
  end

  def get_areas
    puts "Select a region (type 'region') or Ski Resort (type 'resort') to study associated ski trail maps!"
    puts '-----------------------------------------------------------------------'
    puts "Or check out the world map to find resorts and trails: (type 'world')"
    puts '-----------------------------------------------------------------------'
    puts "Enter the area you would like to search:"
    puts '-->'
    input = nil
    while input != 'exit'
      input = gets.strip.downcase
      case input
      when "region"
        puts "These are the resorts in the region..."
      when "world"
        Launchy.open("http://openskimap.org/")
      when "resort"
        get_map
      else 
        "Please enter 'region', 'resort', or 'world'"
      end
    end
  end

  def goodbye
    puts "Come back anytime for more maps!"
  end
end