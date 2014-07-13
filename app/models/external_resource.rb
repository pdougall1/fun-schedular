require 'uri'

class ExternalResource


  def get_google_places (query)
    
  end

  def make_request uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    # request.basic_auth(ID, PASSWORD)
    http.request(request)
  end

  def _get_response (uri_name)
    uri = URI.parse(self.send(:uri_name))
    make_request uri
  end

  def places_uri #(query) # as hash
    query = 'dominos'
    key = ENV['FUN_SCHEDULAR_GOOGLE']
    url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'
    params = { query: query, key: key }
    uri = URI.parse(url)
    uri.query = CGI.unescape(query)
    response = (make_request(uri))
    debugger
    puts 'dougs'
  end

end