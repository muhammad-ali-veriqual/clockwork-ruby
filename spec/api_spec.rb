require File.join( File.dirname(__FILE__) + "/spec_helper" )

describe "API", "#initialize" do

  it "should raise a Clockwork::InvalidAPIKeyError if no API key is passed" do
    expect { Clockwork::API.new('') }.to raise_error Clockwork::InvalidAPIKeyError
  end
  
  it "should raise a Clockwork::InvalidAPIKeyError if an invalid API key is passed" do
    invalid_keys = %w{
    q4353q345325325432
    vsdfgihet8f7yi4u7ttf4guyi
    af7a8f7a8fa7f8a76fa876fa876a876fa875a87
    af7a8f7a8fa7f8a76fa876fa876a876fa875a875a
    }
    
    invalid_keys.each do |k|
      expect { Clockwork::API.new(k) }.to raise_error Clockwork::InvalidAPIKeyError
    end
  end
  
  it "should return a valid instance of Clockwork::API if a valid API key is passed" do
    api = Clockwork::API.new 'af7a8f7a8fa7f8a76fa876fa876a876fa875a875'
    api.should be_a_kind_of Clockwork::API
  end
  
  it "should raise an ArgumentError if two paramters are passed but either username or password is blank" do
    expect { Clockwork::API.new('username', '') }.to raise_error ArgumentError
    expect { Clockwork::API.new('password', '') }.to raise_error ArgumentError
    expect { Clockwork::API.new('', '') }.to raise_error ArgumentError
  end
  
  it "should raise an ArgumentError if more than two parameters are passed" do
    expect { Clockwork::API.new('', '', '') }.to raise_error ArgumentError
  end

end

describe "API", "#invalid_char_action" do

  it "should raise an ArgumentError if value is not one of :error, :replace, :remove" do
    api = Clockwork::API.new 'af7a8f7a8fa7f8a76fa876fa876a876fa875a875'
    expect { api.invalid_char_action = '123' }.to raise_error ArgumentError
    expect { api.invalid_char_action = 'ERROR' }.to raise_error ArgumentError
    
    # Allow strings, too...
    expect { api.invalid_char_action = 'error' }.to_not raise_error ArgumentError   
    
    # Allowed values
    expect { api.invalid_char_action = :error }.to_not raise_error ArgumentError    
    expect { api.invalid_char_action = :replace }.to_not raise_error ArgumentError
    expect { api.invalid_char_action = :remove }.to_not raise_error ArgumentError
  end

end