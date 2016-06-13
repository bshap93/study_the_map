require 'spec_helper'

describe LookupIDS do
  describe "self.index" do
    context "any" do
      it "returns fixtures/index" do
        binding.pry
        expect(LookupIDS.index).to eql(0)
      end
    end
  end
end