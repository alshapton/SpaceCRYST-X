# TODO: Write documentation for `SpaceCRYST::X`
require "crest"
require "./utils"
require "./interface"

module SpaceCRYST::X
  VERSION = "0.1.0"

  i = SpaceCRYST.new
  i.crew
  puts(i.response)

end
