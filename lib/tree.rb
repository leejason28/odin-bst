require_relative './node'

class Tree

  attr_accessor :root

  def initialize(arr)
    sorted = merge_sort(arr.uniq)
    @root = build_tree(sorted)
  end

  def build_tree(arr)
    #sort array
    #find middle of array -> set as root
    #recursively set root.left and root.right as build_tree(left/right_half)
    #return root
    if arr.length == 1
      return Node.new(arr[0])
    end
    root = Node.new(arr[arr.length/2])
    root.left = build_tree(arr[0..(arr.length/2)-1])
    root.right = build_tree(arr[(arr.length/2)..-1])
    root
  end
  
  def insert(root = @root, value)
    if !root
      return Node.new(value)
    else
      if value == root.data
        return root
      elsif value < root.data
        root.left = insert(root.left, value)
      else
        root.right = insert(root.right, value)
      end
    end
    root
  end
  
  def delete(root = @root, value)
    #if no children. done
    #if 1 child. push up rightmost child if on left or leftmost child if on right
    #if 2 children. push rightmost child of left or leftmost child of right
    if !root
      return root
    end
    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    else
      if !root.left
        temp = root.right
        root = nil
        return temp
      elsif !root.right
        temp = root.left
        root = nil
        return temp
      end
      temp = min_value_node(root.right)
      root.data = temp.data
      root.right = delete(root.right, temp.data)
    end
    root
  end

  def min_value_node(node)
    pointer = node
    while pointer.left
      pointer = pointer.left
    end
    pointer
  end
  
  def find(root = @root, value)
    if !root || root.data==value
      return root
    end
    if value < root.data
      return find(root.left, value)
    end
    return find(root.right, value)
  end
  
  def level_order(root = @root, queue = [])
    #bfs
    if !root
      return
    else
      yield(root)
      queue.push(root.left)
      queue.push(root.right)
      level_order(queue[0], queue[1..-1])
    end
  end
  
  def inorder(root = @root, arr = [], &block)
    #left,root,right
    if root
      if block_given?
        inorder(root.left, arr, &block)
        yield(root)
        inorder(root.right, arr, &block)
      else
        inorder(root.left, arr, &block)
        arr.push(root.data)
        inorder(root.right, arr, &block)
      end
    end
    if !block_given?
      arr
    end
  end
  
  def preorder(root = @root, arr = [], &block)
    #root,left,right
    if root
      if block_given?
        yield(root)
        preorder(root.left, arr, &block)
        preorder(root.right, arr, &block)
      else
        arr.push(root.data)
        preorder(root.left, arr, &block)
        preorder(root.right, arr, &block)
      end
    end
    if !block_given?
      arr
    end
  end
  
  def postorder(root = @root, arr = [], &block)
    #left,right,root
    if root
      if block_given?
        postorder(root.left, arr, &block)
        postorder(root.right, arr, &block)
        yield(root)
      else
        postorder(root.left, arr, &block)
        postorder(root.right, arr, &block)
        arr.push(root.data)
      end
    end
    if !block_given?
      arr
    end
  end
  
  def height(node)
    if !node
      return 0
    else
      left_height = height(node.left)
      right_height = height(node.right)
      if left_height > right_height
        return left_height + 1
      else
        return right_height + 1
      end
    end
  end
  
  def depth(root = @root, node)
    if !root || root == node
      return 0
    end
    if node < root
      return depth(root.left, node) + 1
    end
    return depth(root.right, node) + 1
  end
  
  def balanced?
    left_height = height(self.root.left)
    right_height = height(self.root.right)
    return left_height-right_height <= 1 && left_height-right_height >= -1
  end
  
  def rebalance
  
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

def merge_sort(arr)
  if arr.length < 2
    arr
  else
    left = arr[0..(arr.length/2)-1]     # left will always be shorter in event of odd # elements
    right = arr[arr.length/2..-1]
    merge(merge_sort(left), merge_sort(right))
    # sort left half
    # sort right half
    # merge sorted halves
  end
end

def merge(left, right)
  lind = 0
  rind = 0
  arr = []
  while lind<left.length && rind<right.length

    if left[lind] <= right[rind]      # if we have identical elements, we will pull from left side first
      arr.push(left[lind])
      lind += 1
    else
      arr.push(right[rind])
      rind += 1
    end

    if lind==left.length
      arr << right[rind..-1]
      rind = right.length
    elsif rind==right.length
      arr << left[lind..-1]
      lind = left.length
    end

  end
  arr.flatten
end