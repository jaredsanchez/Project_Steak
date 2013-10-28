require 'open-uri'              # allows open('http://...') to return body
require 'nokogiri'              # XML parser

module OrgUnitsControllerHelper
	def getOrgs(level)
		uri = "https://apis-dev.berkeley.edu/cxf/asws/orgunit?level=" + 
		level.to_s + "&_type=xml&app_id=47354f3a&app_key=16cd17108453d708308849e49152f7bb"
		begin
      		xml = URI.parse(uri).read
    	rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      		Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
      		Net::ProtocolError => e
      		# convert all of these into a generic OracleOfBacon::NetworkError,
      		#  but keep the original error message
      		# your code 
      		raise OracleOfBacon::NetworkError, e
    	end
    	doc = Nokogiri::XML(xml)
    end
end
