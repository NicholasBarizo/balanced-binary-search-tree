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

  def sort(input)
    sorted = true
    input.each_with_index do |num, ind|
      next if ind.zero?

      first = input[ind - 1]
      second = num
      next if first < second

      sorted = false
      input[ind] = first
      input[ind - 1] = second
    end
    input = sort(input) if sorted == false
    input
  end

  def build_tree(array, i=0)
    array = sort(array.uniq) if i.zero?
    return Node.new(array[0], nil, nil) if array.length == 1
    return Node.new(array[0], Node.new(array[1], nil, nil), nil) if array.length == 2 && array[1] < array[0]
    return Node.new(array[0], nil, Node.new(array[1], nil, nil)) if array.length == 2

    data = array[array.length / 2]
    left_node = build_tree(array.slice(0, array.length / 2), i + 1)
    right_node = build_tree(array.slice(array.length / 2 + 1, array.length), i + 1)
    @root = Node.new(data, left_node, right_node)
  end

  def insert
    @root
  end

  # Pretty print provided by The Odin Project
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end

test_tree = Tree.new([1, 9, 6, 8, 3, 4, 2, 1, 11])
puts 'root:'
p test_tree.root
p test_tree.pretty_print
