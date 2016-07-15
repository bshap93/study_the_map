require 'spec_helper'

describe Region do
  describe "initialize" do
    context "British Columbia" do
      it "sets region info and region_id" do
        british_columbia = Region.new("British Columbia")
        expect(british_columbia.region_info.search("region").attr('id').text).to eq(RegionScraper.new("British Columbia").region_info.search("region").attr('id').text)
      end
    end
  end

  describe ".starts_with" do
    context "e" do
      it "isn't nil" do


        expect(Region.starts_with("e")).not_to be_nil
      end
    end
  end

  describe "full list" do
    context "British Columbia" do 
      it "to print a ski resort" do
        british_columbia = Region.new("British Columbia")
        output = capture_puts{ british_columbia.full_list }
        rows = output.split("\n")

        expect(rows[0]).to eq("1. 108 Mile House")
      end
    end
  end
end