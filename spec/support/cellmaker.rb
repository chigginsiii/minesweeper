class CellMaker
	include FactoryGirl::Syntax::Methods

	#
	# this needs a method to take a stringed-board of codes
	# that can create these cells and assign the row/col automatically
	#

	# hidden-cell
	def hc(row,col)
		build :cell, row: row, col: col
	end

  # revealed-cell, 
	def rc(row,col)
		build :cell, :revealed, row: row, col: col
	end

	# hidden-mine
	def hm(row,col)
		build :cell, :mine, row: row, col: col
	end

  # revealed-mine,
	def rm(row,col)
		build :cell, :mine, :revealed, row: row, col: col
	end

	# flagged-cell
	def fc(row,col)
		build :cell, :flagged, row: row, col: col
	end

	# flagged-mine
	def fm(row,col)
		build :cell, :flagged, :mine, row: row, col: col
	end
end