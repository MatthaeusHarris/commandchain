require_relative '../../lib/link'
require_relative '../../lib/logger'

module CommandChain
  class Command1 < Link
    def initialize(state)
      @logger = Logger.new
      @state = state
    end

    def validate_inputs
      @logger.info "Command1 class validating inputs"
    end

    def validate_outputs
      @logger.info "Command1 class validating outputs"
    end

    def execute
      @logger.info "Command1 class executing"
      @state
    end

    def unexecute
      @logger.info "Command1 class unexecuting"
      state
    end

  end 
end