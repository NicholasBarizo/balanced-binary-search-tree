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
    Node.new(data, left_node, right_node)
  end

  def insert(value, node = @root)
    if value > node.data
      node.right_node = if node.right_node
                          insert(value, node.right_node)
                        else
                          node.right_node = Node.new(value, nil, nil)
                        end
    elsif value < node.data
      node.left_node = if node.left_node
                         insert(value, node.left_node)
                       else
                         Node.new(value, nil, nil)
                       end
    else
      puts 'ERROR: DUPLICATE IN ARRAY'
    end
    node
  end

  def delete(value, node = @root)
    if node.data == value
      return nil if node.right_node.nil? && node.left_node.nil?
      return node.left_node if node.right_node.nil?
      return node.right_node if node.left_node.nil?

      new_data = node.right_node
      new_data = new_data.left_node while new_data.left_node
      node = delete(new_data.data, node)
      node.data = new_data.data
      return node
    end

    node.right_node = delete(value, node.right_node) unless node.right_node.nil?
    node.left_node = delete(value, node.left_node) unless node.left_node.nil?
    node
  end

  def find(value, node = @root)
    left = find(value, node.left_node) if node.left_node
    right = find(value, node.right_node) if node.right_node
    return left if left && left.data == value
    return right if right && right.data == value

    node
  end

  def level_order(array = [], queue = [@root])
    until queue.empty?
      queue.push queue[0].left_node if queue[0].left_node
      queue.push queue[0].right_node if queue[0].right_node
      array.push queue[0].data
      queue.shift
    end
    array
  end

  def preorder(array = [], node = @root)
    array.push node.data
    array = preorder(array, node.left_node) if node.left_node
    array = preorder(array, node.right_node) if node.right_node
    array
  end

  def postorder(array = [], node = @root)
    array = postorder(array, node.left_node) if node.left_node
    array = postorder(array, node.right_node) if node.right_node
    array.push(node.data)
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
test_tree.pretty_print
test_tree.insert(20)
test_tree.insert(7)
test_tree.pretty_print
test_tree.delete(6)
test_tree.pretty_print
test_tree.delete(9)
test_tree.pretty_print
test_tree.pretty_print(test_tree.find(3))
p test_tree.level_order
p test_tree.preorder
p test_tree.postorder
