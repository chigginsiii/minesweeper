module Minesweeper
	class StatusEntity
		attr_accessor :state, :result

		def initialize
			@state  = :in_progress
			@result = :incomplete
		end

		#
		# command
		#

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
			retval = "#{@state}"
			retval += ":#{@result}" if complete?
			retval
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
