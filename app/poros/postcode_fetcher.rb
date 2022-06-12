require "uri"
require "net/http"
require "json"
module PostcodeFetcher
  BASE_URL = "http://postcodes.io/postcodes/"
  class WrappedResponse
    attr_reader :base_hash
    def initialize(result_hash)
      @base_hash = result_hash
      result_hash.keys.each do |name|
        define_singleton_method(name) do
          raise ArgumentError unless base_hash.has_key?(name)
          base_hash[name]
        end
        define_singleton_method("#{name}=") do |new_value|
          raise ArgumentError unless base_hash.has_key?(name)
          base_hash[name] = new_value
        end
      end
    end
  end

  def self.fetch(postcode)
    uri = URI(BASE_URL + postcode.gsub(/[[:space:]]/, ""))
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      response_body = JSON.parse(res.body)["result"]
      WrappedResponse.new(response_body)
    else
      false
    end
  end
end
