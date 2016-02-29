module Minesweeper
	class CellEntity

		attr_reader :type

		class << self
			def mine
				new type: :mine
			end

			def safe
				new type: :safe
			end
		end

		def initialize (type:)
			@type 		= type
			@revealed = false
		end

		def mine?
			type == :mine
		end

		def hidden?
			!@revealed
		end

		def reveal
			@revealed = true
		end
	end
end