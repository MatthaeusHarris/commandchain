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
      string << " #{key}=#{value}"
    end

    string
	end
end