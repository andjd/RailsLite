require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      c2 = req.cookies.select { |c| c.name == "_rails_lite_app"}
      unless c2.empty?
        val = c2.first.value
        @sesh = JSON.parse(val)
      else
        @sesh = {}
      end

    end

    def [](key)
      @sesh[key]
    end

    def []=(key, val)
      @sesh[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies  << WEBrick::Cookie.new("_rails_lite_app", @sesh.to_json)
    end
  end
end
