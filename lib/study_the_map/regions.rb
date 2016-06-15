
class Region

  attr_accessor :ski_areas , :region_id, :region_info

  def initialize(region)

    region_data = RegionScraper.new(region)
    @region_info = region_data.region_info
 
    self.region_id = @region_info.search("region").attr('id').text
    

    puts "Here are the ski resorts in #{region}:"

    self.ski_areas = region_data.scrape_ski_areas

  end

  def self.starts_with(letter)
    # regions that start with
    regions_starts_with_letter = RegionScraper.regions_list.select {|region_name| region_name.start_with?(letter.upcase)}
    regions_starts_with_letter.each.with_index(1) {|region_name, index| puts "#{index}. #{region_name}"}

  end


  def full_list

    self.ski_areas.each.with_index(1){|area, i| puts "#{i}. #{area}"}

  end

end
