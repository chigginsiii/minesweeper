module Minesweeper
	class StatusEntity
		attr_accessor :state, :result

		def initialize
			@state  = :initial
			@result = :incomplete
		end

		#
		# command
		#

		def begin
			@state = :in_progress
		end

		def complete(result)
			validate_result result
			@state  = :complete
			@result = result
		end

		#
		# query
		#

		def complete?
			@state == :complete
		end

		def in_progress?
			@state == :in_progress
		end

		def won?
			@result == :won
		end

		def lost?
			@result == :lost
		end

		#
		# util
		#

		def to_s
			retval = @state.to_s
			retval += ":#{@result}" if complete?
		end

		def to_str
			to_s
		end

		private

		def validate_result(result)
			raise StatusError, "invalid result '#{result}' (:won, :lost)" unless [:won, :lost].include? result
		end
	end
end
