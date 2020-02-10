require "http/params"
require "json"

struct A
  include JSON::Serializable
  include JSON::Serializable::Unmapped
end

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

class JSONtoHTTP
  property jsonParams : String
  property httpParams : String
  def initialize
    @jsonParams="[]"
    @httpParams = ""
    enteredParams = @jsonParams
    enteredParams="{\"status\":\"active\",\"fred\":\"flintstone\",\"name\":12}"
    haash = JSON.parse(enteredParams).as_h

    

    params = HTTP::Params.build do |form|
      haash.each do |ky| 
        done=false
      begin
        tmp=typeof(ky[1].to_s)
        done=true
        form.add ky[0], (ky[1].to_s)
      rescue ex : TypeCastError
      end

    end
    end
    puts(params)
    #@httpParams=HTTP::Params.encode(Hash(String, JSON::Any).from_json(enteredParams))
    #@httpParams=HTTP::Params.encode(Hash(String, JSON::Any),enteredParams)
    #puts(params)
  end
end