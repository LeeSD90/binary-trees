require './node.rb'
require 'benchmark'

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

	def breadth_first_search(value)
		queue = [@root]
		while !queue.empty?
			if queue[0].value == value then return queue[0] end
			queue << queue[0].l_child unless queue[0].l_child.nil?
			queue << queue[0].r_child unless queue[0].r_child.nil?
			queue.shift
		end
		return nil
	end

	def depth_first_search(value)
		stack = [@root]
		while !stack.empty?
			top = stack.pop
			if top.value == value then return top end
			stack << top.l_child unless top.l_child.nil?
			stack << top.r_child unless top.r_child.nil?
		end
		return nil
	end

	def dfs_rec(value, current=@root)
		if current.value == value then return current end

		left = dfs_rec(value, current.l_child) unless current.l_child.nil?
		if !left.nil? && left.value == value then return left end

		right = dfs_rec(value, current.r_child) unless current.r_child.nil?
		if !right.nil? && right.value == value then return right end

		return nil
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

tree = BinaryTree.new(Array.new(100000){rand(1..100000)})
test_var = nil
until !test_var.nil?
	test_var = tree.breadth_first_search(rand(1..100000))
end

puts "\nTesting " + test_var.value.to_s
puts "BFS:                " + Benchmark.measure{tree.breadth_first_search(test_var.value)}.to_s
puts "DFS:                " + Benchmark.measure{tree.depth_first_search(test_var.value)}.to_s
puts "DFS with recursion: " + Benchmark.measure{tree.dfs_rec(test_var.value)}.to_s
