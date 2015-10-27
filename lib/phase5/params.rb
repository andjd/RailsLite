require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string)
      parse_www_encoded_form(req.body)
      @params.keys.map!(&:to_s)
    end

    def [](key)
      @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(form)
      return nil if form.nil?
      a = URI.decode_www_form(form)
      p a
      out = {}
      a.each do |tuple|
        p tuple
        k, v = tuple
        out.merge!({k => v})
      end
      p out
      @params.merge! out

      nil
    end

    def nest_hash
      new_params = {}
      @params.each do |param_key, param_val|
        if strip_key = param_key.gsub("]","")
          new_key = unnest_key(strip_key)

        else
        new_params.merge!({param_key => param_val})


    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
    end
  end
end
