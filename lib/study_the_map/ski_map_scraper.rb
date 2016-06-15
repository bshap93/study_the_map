class SkiMapScraper

  def initialize(area_name)
    @url = "https://skimap.org/SkiAreas/view/#{LookupIDS.find_ski_area_id(area_name)}.xml"
  end

  def area_info
    Nokogiri::XML(open(@url))
  end

  def scrape_map_ids

    id_array = []

    self.area_info.search("skiMaps skiMap").each do |map|
      id_array << map.attr('id')
    end

    id_array

  end

  def scrape_map_data

    self.scrape_map_ids.collect do |id|
      Nokogiri::XML(open("https://skimap.org/SkiMaps/view/#{id}.xml"))
    end

  end

  def scrape_map_years

    self.scrape_map_data.collect do |map|
      map.search("yearPublished").text
    end

  end

  def map_count
    self.area_info.search("skiMaps").attr('count').text
  end

end