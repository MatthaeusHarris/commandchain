require_relative '../../lib/link'
require_relative '../../lib/logger'

module CommandChain
	class Fail < Link
		def initialize(state)
			@logger = Logger.new
			@state = state
		end

		def validate_inputs
			assert "don't fail in validate_inputs" do
				@state['pass_validate_inputs']
			end

			@logger.info "Validated", {:state => @state}

		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def execute
			raise StandardError.new("Failing in execute") unless @state['pass_execute']
			@state

		rescue StandardError => e
			raise ExecuteError.new(e.message)
		end

		def validate_outputs
			assert "don't fail in validate_outputs" do
				@state['pass_validate_outputs']
			end
			
			@logger.info "Validated", {:state => @state}

		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def unexecute(state)
			@logger.info "Dummy unexecute in Fail"
			state
		end
	end
end
