require 'uri'
require_relative "params_helper"  #warning: monkey-patches Hash

module Phase5
  class Params

    def self.parse_www_encoded_form(form)
      return nil if form.nil?
      a = URI.decode_www_form(form)
      out = {}
      a.each do |tuple|
        k, v = tuple
        out.merge!({k => v})
      end

      out

    end
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = Hash.new

      query_string_params = self.class.parse_www_encoded_form(req.query_string)
      @params.merge! query_string_params unless query_string_params.nil?

      body_params = self.class.parse_www_encoded_form(req.body)
      @params.merge! body_params unless body_params.nil?

      route_params = route_params.reduce({}) do |out, tuple|
        k, v = tuple
        out.merge({k.to_s => v})
      end

      @params.merge! route_params

      nest_hash!

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


    def nest_hash!
      new_params = {}
      @params.each_pair do |tuple|
        hashed_param = unnest_key(*tuple)
        new_params = deep_merge(new_params, hashed_param)
      end

      @params = new_params
    end


    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
    end
  end
end
