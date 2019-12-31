class URLS
  property main_url
  getter main_url : String

  def initialize
    # Base URL from which to assemble request URLs
    base = "https://api.spacexdata.com"

    # API Version
    version = "v3"
    @main_url = base + "/" + version + "/"
  end
end
