require "./spec_helper"
require "json"

struct A
  include JSON::Serializable
  include JSON::Serializable::Unmapped
end

describe "Testing SpaceCRYST::X " do
  
  describe "Testing Crew" do
    it "Crew is OK" do
      i = SpaceCRYST.new
      i.crew
      i.response.should eq("[]") 
    end
  end 

  describe "Testing Capsules" do
    i = SpaceCRYST.new
    i.capsules  
    it "Capsules.size is OK" do
      capsules = Array(A).from_json(i.response)
      # There should be more than zero items in the capsules array
      capsules.size.should be > 0
  end

  it "Capsules (content) is OK" do
    capsules = Array(A).from_json(i.response)
    capsules.each do |ky|
    capsule = ky.json_unmapped
    c=capsule["capsule_serial"].as_s
    if c == "C102"
      capsule["capsule_serial"].should eq("C102")
    end
  end
end
end
end