require './lib/study_the_map.rb'

class Region

  attr_accessor :ski_areas, :region_id

  def initialize(region)
    doc = Nokogiri::XML(open("https://skimap.org/Regions/view/#{LookupIDS.find_region_id(region)}.xml"))
    self.region_id = doc.search("region").attr('id').text
    puts "Ski Area ID: #{self.region_id}"
    self.ski_areas = doc.search("skiArea").collect do |ski_area|
      "#{ski_area.text}, ID: #{ski_area['id']}"
    end
  end

  def starts_with(letter)
    results = self.ski_areas.select do |area| 
      area.start_with?("#{letter}", "#{letter.upcase}")
    end
    results.each.with_index(1){|area, i| puts "#{i}. #{area}"}
  end

  def full_list
    self.ski_areas.each.with_index(1){|area, i| puts "#{i}. #{area}"}
  end
end
