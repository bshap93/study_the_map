# require './lib/study_the_map.rb'

class SkiMaps

  attr_accessor :area_name, :area_info, :map_count

  def initialize(area_name)

    @area_name = area_name

    @area_info = SkiMapScraper.new(area_name)
    @map_count = @area_info.map_count

 
  end

end
