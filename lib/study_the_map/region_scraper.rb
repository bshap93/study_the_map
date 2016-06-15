class RegionScraper

  def initialize(region_name)
    @url = "https://skimap.org/Regions/view/#{LookupIDS.find_region_id(region_name)}.xml"
  end

  def region_info
    Nokogiri::XML(open(@url))
  end

  def scrape_ski_areas
    self.region_info.search("skiArea").collect do |ski_area|
      "#{ski_area.text}"
    end
  end

  def self.regions_list

    LookupIDS.index.css("regions region").collect do |region|
      region.text.strip
    end.uniq

  end

  def self.ski_area_list

    LookupIDS.index.search("skiArea name").map {|ski_area| ski_area.text}
    
  end

end