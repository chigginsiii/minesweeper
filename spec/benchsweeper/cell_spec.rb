RSpec.describe Benchsweeper::Cell do
	let(:cell) { described_class.new value, row_i, col_i }
	let(:value) { 'X' }
	let(:row_i) { 3 }
	let(:col_i) { 7 }

	describe '#status' do
		subject { cell.status }
		[
			{                  val: 'F', status: :flagged },
			{                  val: 'M', status: :mine },
			{ label: 'digit',  val: '4', status: :revealed },
			{ label: 'period', val: '.', status: :revealed },
			{ label: 'other',  val: 'x', status: :hidden }
		].each do |profile|
			context "when value is #{profile[:label] || profile[:val]}" do
				let(:value) { profile[:val] }
				it { is_expected.to eq profile[:status] }
			end
		end
	end

	#
	# status queries: status == :hidden | hidden? == true
	#
	[ :hidden, :flagged, :mine, :revealed ].each do |status|
		describe "##{status}?" do
			context "when status is :#{status}" do
				before { cell.instance_variable_set(:@status, status) }
				it 'is true' do
					expect(cell.send("#{status}?".to_sym)).to eq true
				end
			end
			context "when status is not :#{status}" do
				before { cell.instance_variable_set(:@status, :bogus) }
				it 'is false' do
					expect(cell.send("#{status}?".to_sym)).to eq false
				end
			end
		end
	end

	describe '#row' do
		it 'increments init arg' do
			expect(cell.row).to eq row_i + 1
		end
	end

	describe '#col' do
		it 'increments init arg' do
			expect(cell.col).to eq col_i + 1
		end
	end		

	describe '#up' do
		it 'is one less than row' do
			expect(cell.up).to eq cell.row - 1
		end
	end

	describe '#down' do
		it 'is one more than row' do
			expect(cell.down).to eq cell.row + 1
		end
	end

	describe '#left' do
		it 'is one less than col' do
			expect(cell.left).to eq cell.col - 1
		end
	end

	describe '#right' do
		it 'is one more than col' do
			expect(cell.right).to eq cell.col + 1
		end
	end

	describe '#coords' do
		it 'makes a key from row:col' do
			expect(cell.coords).to eq "#{cell.row}:#{cell.col}"
		end
	end
end