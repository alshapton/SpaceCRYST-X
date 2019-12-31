require "./urls.cr"

# A SpaceCRYST is an object that contains methods to access
# information about **Space/X**.
# This class does **NOT** have any affiliation with Space/X.
class SpaceCRYST
  property response
  getter response : String
  property main_url : String
  property i : SyncHttp

  def initialize
    # Get main URL
    urls = URLS.new
    @main_url = urls.main_url

    # Initialise response
    @response = "X"
    @i = SyncHttp.new
  end

  # Capsules
  def capsules : String
    i.url = @main_url + "capsules"
    i.request
    @response = i.response
  end

  def upcomingCapsules : String
    i.url = @main_url + "capsules/upcoming"
    i.request
    @response = i.response
  end

  def pastCapsules : String
    i.url = @main_url + "capsules/past"
    i.request
    @response = i.response
  end

  # Company
  def info : String
    i.url = @main_url + "info"
    i.request
    @response = i.response
  end

  def company : String
    i.url = @main_url
    i.request
    @response = i.response
  end

  # Cores
  def cores : String
    i.url = @main_url + "cores"
    i.request
    @response = i.response
  end

  def upcomingCores : String
    i.url = @main_url + "cores/upcoming"
    i.request
    @response = i.response
  end

  def pastCores : String
    i.url = @main_url + "cores/past"
    i.request
    @response = i.response
  end

  # Crew
  def crew : String
    i.url = @main_url + "crew"
    i.request
    @response = i.response
  end
end
