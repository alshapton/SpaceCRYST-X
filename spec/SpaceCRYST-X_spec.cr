require "./spec_helper"
require "json"

struct A
  include JSON::Serializable
  include JSON::Serializable::Unmapped
end

describe "Testing SpaceCRYST::X " do

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

    it "Capsules (contentfilter) is OK" do
      i.params = "{'status':'active'}"
      i.capsules
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

    it "Capsules ONE (C112) is OK" do
      i.one="C112"
      i.oneCapsule
      singleCapsule= Hash(String, JSON::Any).from_json(i.response)
      c = singleCapsule["type"].as_s
      # If this capsule's type is correct (i.e. C112 is a Dragon 1.1) then all should be fine
      c.should eq("Dragon 1.1")
    end

    it "Capsules /upcoming is OK" do
      i.upcomingCapsules
      capsules = Array(A).from_json(i.response)
      all_null=true
      capsules.each do |ky|
        capsule = ky.json_unmapped
        if capsule["original_launch"] != nil
          # Capsules upcoming MUST have a nill launch date
          all_null = false  
        end
      end
      all_null.should be_true
    end
    
    it "Capsules /past is OK" do
      i.pastCapsules
      capsules = Array(A).from_json(i.response)
      launch_dates = true
      capsules.each do |ky|
        capsule = ky.json_unmapped
        if capsule["original_launch"] == nil
          # Capsules upcoming MUST NOT have a nill launch date
          launch_dates = false  
        end
      end
      launch_dates.should be_true
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

  describe "Testing API Information" do
    i = SpaceCRYST.new
    i.company
    api = Hash(String, JSON::Any).from_json(i.response)
    it "API name is OK" do
      api["project_name"].as_s.should eq("SpaceX-API")
    end
    it "Github URL is OK" do
      api["organization_link"].as_s.should eq("https://github.com/r-spacex")
    end
  end

  describe "Testing Crew" do
    it "Crew is OK" do
      i = SpaceCRYST.new
      i.crew
      i.response.should eq("[]")
    end
  end
end
