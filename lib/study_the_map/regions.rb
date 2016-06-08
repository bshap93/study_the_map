require './lib/study_the_map.rb'

class Region

  attr_accessor :ski_areas, :region_id

  def initialize(region)

    doc = Nokogiri::XML(open("https://skimap.org/Regions/view/#{LookupIDS.find_region_id(region)}.xml"))
    self.region_id = doc.search("region").attr('id').text

    puts "Here are the ski resorts in #{region}:"

    self.ski_areas = doc.search("skiArea").collect do |ski_area|
      "#{ski_area.text}"
    end

  end

  def self.starts_with(letter)
    # regions that start with
    regions_starts_with_letter = self.regions_list.select {|region_name| region_name.start_with?(letter.upcase)}
    regions_starts_with_letter.each.with_index(1) {|region_name, index| puts "#{index}. #{region_name}"}

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

  def self.regions_list

    regions_list_array = []
    LookupIDS.index.css("regions region").each do |region|
      regions_list_array << region.text.strip
    end
    regions_list_array.uniq

  end

  def self.ski_area_list

    LookupIDS.index.search("skiArea name").map {|ski_area| ski_area.text}
    
  end
end
