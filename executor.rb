require_relative "logger"

module CommandChain
  class Executor
    def initialize(chain)
      @logger = Logger.new

      raise InvalidInvocation.new("Executor requires an array argument") unless chain.class == Array

      @links = []

      chain.each do |link|
        require_relative "links/#{link}"
        @links << link
      end
    end

    def run!

    end
  end

  class InvalidInvocation < StandardError
  end
end