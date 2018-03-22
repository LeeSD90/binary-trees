class Node
	attr_accessor :value, :parent, :l_child, :r_child

	def initialize(value)
		@value = value
		@parent = nil
		@l_child = nil
		@r_child = nil
	end
end