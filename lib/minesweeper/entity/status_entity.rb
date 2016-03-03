module Minesweeper
	class StatusEntity
		attr_accessor :state, :result
		def initialize
			@state = :initial
			@result = :incomplete
		end

		#
		# command
		#

		def begin
			@state = :in_prog
		end

		def complete
			@state = :complete
			self
		end

		def win
			@result = :won
			self
		end

		def lose
			@result = :lost
			self
		end

		#
		# query
		#

		def complete?
			@state == :complete
		end

		def in_progress?
			@state == :in_progress

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
			"#{@state}#{complete? ? @result : ''}")
		end
	end
end

