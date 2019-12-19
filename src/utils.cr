  class SyncHttp
    property response
    property url 

    getter response : String
    getter url : String
    
    def initialize
        @response="X"
        @url="X"
    end

    def request
      callapi = Crest.get(@url, tls: OpenSSL::SSL::Context::Client.insecure, handle_errors: false) do |resp|
      case resp
      when .success?
        #puts(resp)
        #puts resp.body_io.gets_to_end
        @response= resp.body_io.gets_to_end
        
      when .client_error?
        puts "Client error"
      when .server_error?
        puts "Server error"
      end
    end
end
end 