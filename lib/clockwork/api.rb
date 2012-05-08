# A wrapper around the Clockwork API.
module Clockwork
  
  # @author James Inman <james@mediaburst.co.uk>
  # 
  # You must create an instance of Clockwork::API to begin using the API.
  class API
    
    SMS_URL = "api.clockworksms.com/xml/send"
    CREDIT_URL  = "api.clockworksms.com/xml/credit"
    
    # @!attribute from
    # The from address displayed on a phone when the SMS is received. This can be either a 12 digit number or 11 characters long.
    # @return [string] 
    # @note This can be overriden for specific Clockwork::SMS objects; if it is not set your account default will be used.
    attr_accessor :from
    
    # @!attribute long
    # Set to true to enable long SMS. A standard text can contain 160 characters, a long SMS supports up to 459. Each recipient will cost up to 3 message credits.
    # @return [boolean]
    # @note This can be overriden for specific Clockwork::SMS objects; if it is not set your account default will be used.
    attr_accessor :long
    
    # @!attribute truncate
    # Set to true to trim the message content to the maximum length if it is too long.
    # @return [boolean] 
    # @note This can be overriden for specific Clockwork::SMS objects; if it is not set your account default will be used.
    attr_accessor :truncate
        
    # What to do with any invalid characters in the message content. +:error+ will raise a Clockwork::InvalidCharacterException, +:replace+ will replace a small number of common invalid characters, such as the smart quotes used by Microsoft Office with a similar match, +:remove+ will remove invalid characters.
    # @raise ArgumentError - if value is not one of +:error+, +:replace+, +:remove+
    # @return [symbol] One of +error+, +:replace+, +:remove+ 
    # @note This can be overriden for specific Clockwork::SMS objects; if it is not set your account default will be used.
    attr_reader :invalid_char_action
    
    # @overload initalize(api_key)
    #   @param [string] api_key API key, 40-character hexadecimal string
    # @overload initalize(username, password)
    #   @param [string] username Your API username
    #   @param [string] password Your API password
    #   @deprecated Use an API key instead. Support for usernames and passwords will be removed in a future version of this wrapper.
    # @raise ArgumentError - if more than two parameters are passed
    # @raise Clockwork::InvalidAPIKeyError - if API key is invalid
    # Clockwork::API is initialized with an API key, available from http://www.mediaburst.co.uk/api.
    def initialize *args
      if args.size == 1
        raise Clockwork::InvalidAPIKeyError unless args[0][/^[A-Fa-f0-9]{40}$/]
      elsif args.size == 2
        raise ArgumentError, "You must pass both a username and password." if args[0].empty? || args[1].empty?
      else
        raise ArgumentError, "You must pass either an API key OR a username and password."
      end
    end
        
    def invalid_char_action= symbol
      raise( ArgumentError, "#{symbol} must be one of :error, :replace, :remove" ) unless [:error, :replace, :remove].include?(symbol.to_sym)
    end
    
  end
  
end