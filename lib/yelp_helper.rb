require 'oauth'
require 'json'

module YelpHelper
  #Ferdi:
  # CONSUMER_KEY = 's3OFJZeLxXg4Zpyik4-Qng'
  # CONSUMER_SECRET = 'CEoKVSBOfl7I_GBsH_5McAqyv0U'
  # TOKEN = 'I0EhDz5uRcD44f5QrL38Bl6vdwSpitlR'
  # TOKEN_SECRET = 'UPrz5Tf3_L_DswN3zu2nCeJ2c4c'
  #Ami:

  CONSUMER_KEY = 'oQp4rtg9Br5pqsu56T_f-Q'
  CONSUMER_SECRET = 'QdxcWLugM2MP7vXsyzZsAO1e9z8'
  TOKEN = 'mtAJKfk5KNHQ1HHfvhFq4pRfp70iWy6v'
  TOKEN_SECRET = 'TlAyQHs-JmhXGNyUlbXRDKz77Lk'

  def self.api_host
    'api.yelp.com'
  end

  def self.api_search_path
    '/v2/search'
  end

  def self.consumer
    @consumer ||= OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {:site => "http://#{api_host}"})
  end

  def self.access_token
    @access_token ||= OAuth::AccessToken.new(consumer, TOKEN, TOKEN_SECRET)
  end

  def self.search(location)
    location ||= "37.788022,-122.399797"
    # puts businesses.length
    # puts coffeeplaces.sort_by!{|i| i[1]}
    get_businesses(location)
  end

  def self.get_businesses(location)
    businesses(location).collect do |coffee|
      [
        coffee['name'],
        coffee['distance'],
        coffee['rating'],
      ]
    end
  end

  def self.query(location)
    access_token.get(path(location)).body
  end

  def self.path(location)
    "#{api_search_path}?term=coffee&ll=#{location}"
  end

  def self.businesses(location)
    JSON.parse(query(location))["businesses"] || []
  end
end