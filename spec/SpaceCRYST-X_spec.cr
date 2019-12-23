require "./spec_helper"
require "json"

struct A
  include JSON::Serializable
  include JSON::Serializable::Unmapped
end


describe SpaceCRYST::X do
  # TODO: Write tests

  it "Crew is fine" do
    i = SpaceCRYST.new
    i.crew
    i.response.should eq("[]") 
  end

  it "Capsules is fine" do
    i = SpaceCRYST.new
    i.capsules
    capsules = Array(A).from_json(i.response)

    capsules.each do |ky|
      capsule=ky.json_unmapped
      puts capsule["capsule_serial"]
    end
end

end
