class LookupIDS


  def self.index

    doc = Nokogiri::XML(open("./lib/fixtures/index.xml"))
    
  end

  def self.find_region_id(region_name)
    
    region_element = self.index.css("regions region").detect do |region|
      region.text.strip == region_name
    end

    region_element['id']

  end

  def self.find_ski_area_id(area_name)

    ski_area_element = self.index.search("skiArea").detect do |ski_area|
      ski_area.search("name").text.strip == area_name
    end

    ski_area_element['id']
    
  end


end