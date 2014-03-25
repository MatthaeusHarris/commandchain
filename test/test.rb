load '../commandchain.rb'

e = CommandChain::Executor.new(['Command1'], {}, 'test/links')
e.run!

e = CommandChain::Executor.new(['Add', 'Add'], {'numbers' => [1, 2, 3, 4, 5]}, 'test/links')
e.run!

e = CommandChain::Executor.new(['Add', 'Average'], {'numbers' => [1, 2, 3, 4, 5]}, 'test/links')
e.run!

e = CommandChain::Executor.new(['Average'], {'numbers' => [1, 2, 3, 4, 5]}, 'test/links')
begin
	e.run!
rescue StandardError => e
	puts "The expected error occurred."
	puts e.message
	puts e.stacktrace
end

