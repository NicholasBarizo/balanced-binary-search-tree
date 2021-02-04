class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data, left_node, right_node)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end
end

class Tree
  attr_accessor :root

  def initialize(input)
    @root = build_tree(input)
  end

  def build_tree(input)
    puts "input: #{input}"
    return nil if input.empty?
    return Node.new(input, nil, nil) if input.length == 1

    if input.length == 2
      p "Input: #{input}"
      return Node.new(input[0], input[1], nil)
    end

    data = input[input.length / 2]
    left_node = build_tree(input.slice(0, input.length / 2))
    right_node = build_tree(input.slice(input.length / 2 + 1, input.length))
    Node.new(data, left_node, right_node)
  end
end

test_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
puts 'root:'
p test_tree.root
