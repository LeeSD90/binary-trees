require './node.rb'

class BinaryTree
	attr_reader :root

	def initialize(ary)
		build_tree(ary)
	end

	def build_tree(ary)
		ary.each do |v|
			if @root.nil?
				@root = Node.new(v)
				next
			end
			node = Node.new(v)
			add_node(node)
		end
	end

	def add_node(node, current=@root)
		if node.value <= current.value
			if current.l_child.nil?
				current.l_child = node
				node.parent = current
			else add_node(node, current.l_child)
			end
		else
			if current.r_child.nil?
				current.r_child = node
				node.parent = current
			else add_node(node, current.r_child)
			end
		end
	end

	def trace(current=@root)
		puts "ROOT: " + current.value.to_s
		puts "LEFT: " + (current.l_child.nil? ? "NIL" : current.l_child.value.to_s)
		puts "RIGHT: " + (current.r_child.nil? ? "NIL" : current.r_child.value.to_s)
		puts
		trace(current.l_child) unless current.l_child.nil?
		trace(current.r_child) unless current.r_child.nil?
	end

end

tree = BinaryTree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.trace
