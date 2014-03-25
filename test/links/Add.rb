require_relative '../../lib/link'
require_relative '../../lib/logger'

module CommandChain
	class Add < Link
		def initialize(state)
			@logger = Logger.new
			@state = state
		end

		def validate_inputs
			assert "state must include numbers" do
				@state.keys.include?("numbers")
			end

			assert "numbers must be an array" do
				@state['numbers'].class == Array
			end

			assert "numbers array must not be empty" do 
				@state['numbers'].length > 0
			end

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
			assert "state must include numbers" do
				@state.keys.include?("numbers")
			end

			assert "numbers must be an array" do
				@state['numbers'].class == Array
			end

			assert "numbers array must not be empty" do 
				@state['numbers'].length > 0
			end

			assert "state must include sum" do 
				@state.keys.include?("sum")
			end

			assert "sum must be a Fixnum" do
				@state['sum'].class == Fixnum
			end

			@logger.info "Validated", {:state => @state}
		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def unexecute(state)
			@logger.info "Unexecute add"
			state.delete('sum')
			state
		end
	end
end
