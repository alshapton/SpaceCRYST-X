# TODO: Write documentation for `SpaceCRYST::X`
require "crest"
require "./utils"

module SpaceCRYST::X
  VERSION = "0.1.0"

  # Base URL from which to assemble request URLs 
  base = "https://api.spacexdata.com"

  # API Version 
  version = "v3"
  main_url = base + "/" + version + "/"

  # Declaration of the endpoints
  
  # Company/API information 
  main_info = main_url + "info"
  main_api = main_url

  company = SyncHttp.new
  company.url=main_info
  company.request
  puts(company.response)
end
