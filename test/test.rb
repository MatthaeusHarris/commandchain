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
	puts e.backtrace
end

e = CommandChain::Executor.new(['Fail'], {'pass_validate_inputs' => true, 'pass_execute' => true, 'pass_validate_outputs' => true}, 'test/links')
e.run!

begin
	e = CommandChain::Executor.new(['Add', 'Average', 'Fail'], {'numbers' => [1, 2, 3]}, 'test/links')
	e.run!
rescue StandardError => e
	puts "The expected error occurred."
	puts e.message
	puts e.backtrace
end

begin
	e = CommandChain::Executor.new(['Add', 'Average', 'Fail'], {'numbers' => [1, 2, 3], 'pass_validate_inputs' => true}, 'test/links')
	e.run!
rescue StandardError => e
	puts "The expected error occurred."
	puts e.message
	puts e.backtrace
end

begin
	e = CommandChain::Executor.new(['Add', 'Average', 'Fail'], {'numbers' => [1, 2, 3], 'pass_validate_inputs' => true, 'pass_execute' => true}, 'test/links')
	e.run!
rescue StandardError => e
	puts "The expected error occurred."
	puts e.message
	puts e.backtrace
end
