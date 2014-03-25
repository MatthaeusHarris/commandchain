require_relative '../../lib/link'
require_relative '../../lib/logger'

module CommandChain
	class Add < Link
		def initialize(state)
			@logger = Logger.new
			@state = state
		end

		def validate_inputs
			assert { @state.keys.include?("numbers") }
			assert { @state['numbers'].class == Array }
			assert { @state['numbers'].length > 0 }
			@logger.info "Validated", {:state => @state}
		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def execute
			@state['sum'] ||= 0
			@state['numbers'].each do |num|
				@state['sum'] += num
			end
			@logger.info "Executed", {:state => @state}
			@state
		rescue StandardError => e
			raise ExecuteError.new(e.message)
		end

		def validate_outputs
			validate_inputs
			assert { @state.keys.include?("sum") }
			@logger.info "Validated", {:state => @state}
		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def unexecute
			@logger.info "Unexecute impossible"
		end
	end
end
