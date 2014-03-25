require 'json'

class Logger
	def info(string, object={})
    if string.class == Hash
      object = string
      string = ""
    end
    puts "#{Time.new.inspect} #{format(string, object)}"
	end

	def format(string, object)
		object.each do |key, value|
      case value
      when Hash
        string << " #{key}=#{value.to_json}"
      when Array
        string << " #{key}=#{value.to_json}"
      else
        string << " #{key}=#{value}"
      end
    end

    string
	end
end