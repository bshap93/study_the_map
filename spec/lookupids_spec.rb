require 'spec_helper'

describe LookupIDS do
  describe "self.index" do
    context "any" do
      it "returns fixtures/index" do
        index = Nokogiri::XML(open("./lib/fixtures/index.xml"))
        expect(LookupIDS.index.text).to eq(index.text)
      end
    end
  end

  describe ".find_region_id" do
    context "given Utah" do
      it "returns '319'" do
        expect(LookupIDS.find_region_id("Utah")).to eq("319")
      end
    end
  end

  describe ".find_ski_area_id" do
    context "given Snowbird Ski and Summer Resort" do
      it "returns '226'" do
        expect(LookupIDS.find_ski_area_id("Snowbird Ski and Summer Resort")).to eq("226")
      end
    end
  end

end