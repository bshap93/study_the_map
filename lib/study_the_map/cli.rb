#CLI controller 
require "./lib/study_the_map.rb"
class StudyTheMap::CLI

  def call
    get_areas
    goodbye
  end

  def get_map
    puts """
      1. Link to map jpg
      2. Link to resort url
    """
  end

  def get_areas
    puts "Select a region or Ski Resort to study associated ski trail maps!"
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
        get_map(resort)
      end
    end
  end

  def goodbye
    puts "Come back anytime for more maps!"
  end
end