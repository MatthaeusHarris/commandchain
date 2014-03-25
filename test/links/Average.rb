require_relative '../../lib/link'
require_relative '../../lib/logger'

module CommandChain
	class Average < Link
		def initialize(state)
			@logger = Logger.new
			@state = state
		end

		def validate_inputs
			assert "state must inclue numbers" do
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

		def execute
			@state['average'] = @state['sum'] / @state['numbers'].length
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

			assert "state must include average" do 
				@state.keys.include?("average") 
			end

			assert "average must be a Fixnum or Float" do 
				@state['average'].class == Fixnum || @state['average'].class == Float 
			end

			@logger.info "Validated", {:state => @state}
		rescue StandardError => e
			raise ValidateError.new(e.message)
		end

		def unexecute(state)
			@logger.info "unexecute average"
			state.delete('average')
			state
		end
	end
end
