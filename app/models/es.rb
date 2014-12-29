class ES

	SEARCH_RESPONSE_KEYS = [:_index, :_type, :_id, :_version, :found, :_source]

	attr_accessor *SEARCH_RESPONSE_KEYS

	def initialize(search_response)
		SEARCH_RESPONSE_KEYS.each do |key|
			self.send("#{key}=", search_response[key.to_s])
		end
	end


end