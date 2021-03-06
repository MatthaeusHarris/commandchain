require_relative "logger"

module CommandChain
  class Executor
    def initialize(chain, initial_state = {}, links_glob = './links/')
      @logger = Logger.new

      raise InvalidInvocation.new("Executor requires an array argument") unless chain.class == Array
      raise InvalidInvocation.new("Executor requires a hash as initial state") unless initial_state.class == Hash
      raise InvalidInvocation.new("Executor requires a string as links_glob") unless links_glob.class == String

      @links = []
      @chain = chain
      @state = initial_state
      @stack = []

      @logger.info "Creating chain", {:chain => chain}

      chain.each do |link|
        require_relative File.join('..', links_glob, link)
        @links << link
      end
    end

    def run!
      @links.each do |link|
        @logger.info "Processing new link", {:link => link}
        link_instance = CommandChain.const_get(link).new(@state)
        begin
          link_instance.validate_inputs
          new_state = link_instance.execute
          @state = new_state
          @stack.push link_instance
          link_instance.validate_outputs

        rescue ExecuteError => e
          puts e.message
          puts e.backtrace
          raise e

        rescue ValidateError => e
          puts e.message
          puts e.backtrace
          raise e
        end
      end
    rescue StandardError
      rollback!
    end

    def rollback!
      @logger.info "Rolling back", {:stack => @stack, :state => @state}
      while link_instance = @stack.pop do
        begin
          @state = link_instance.unexecute(@state)
        rescue ExecuteError => e
          puts e.message
          puts e.backtrace
          @logger.info "Aborting unexecute", {:stack => @stack}
          raise e
        end
      end
    end
  end

  class InvalidInvocation < StandardError
  end
end