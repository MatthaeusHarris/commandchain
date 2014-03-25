module AbstractInterface
  class InterfaceNotImplementedError < NoMethodError
  end

  def self.included(klass)
    klass.send(:include, AbstractInterface::Methods)
    klass.send(:extend, AbstractInterface::Methods)
  end

  module Methods

    def api_not_implemented(klass)
      caller.first.match(/in \`(.+)\'/)
      method_name = $1
      raise AbstractInterface::InterfaceNotImplementedError.new("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
    end

  end

end

module CommandChain

  class ExecuteError < StandardError
  end

  class ValidateError < StandardError
  end

  class Link
    include AbstractInterface

    def validate_inputs
      CommandChain.api_not_implemented(self)
    end

    def validate_outputs
      CommandChain.api_not_implemented(self)
    end

    def execute
      CommandChain.api_not_implemented(self)
    end

    def unexecute
      CommandChain.api_not_implemented(self)
    end

    def assert
      raise StandardError.new("Assertion failed") unless yield
    end
  end
end


