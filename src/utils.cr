class SyncHttp
  property response
  property url

  getter response : String
  getter url : String

  def initialize
    @response = "X"
    @url = "X"
  end

  def request
    callapi = Crest.get(@url, tls: OpenSSL::SSL::Context::Client.insecure, handle_errors: false) do |resp|
      case resp
      when .success?
        @response = resp.body_io.gets_to_end
      when .client_error?
        @response = "Client Error"
      when .server_error?
        @response = "Server Error"
      end
    end
  end
end
