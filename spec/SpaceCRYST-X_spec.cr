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
        c = capsule["capsule_serial"].as_s
        # Searching for a specific capsule, since then we can be sure about the content
        if c == "C102"
          capsule["capsule_serial"].should eq("C102")
        end
      end
    end
  end

  describe "Testing Company Information" do
    i = SpaceCRYST.new
    i.info 
    info = Hash(String, JSON::Any).from_json(i.response)
    it "Company COO is OK" do
      info["coo"].as_s.should eq("Gwynne Shotwell")
    end
    it "Company CTO is OK" do
      info["cto"].as_s.should eq("Elon Musk")
    end
    it "Company CTO Propulsion is OK" do
      info["cto_propulsion"].as_s.should eq("Tom Mueller")
    end
  end
end