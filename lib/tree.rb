require_relative './node'

class Tree

  attr_accessor :root

  def initialize(arr)
    sorted = merge_sort(arr)
    @root = build_tree(sorted)
  end

  def build_tree(arr)
    #sort array
    #find middle of array -> set as root
    #recursively set root.left and root.right as build_tree(left/right_half)
    #return root
    if arr.length <= 1
      return Node.new(arr[0])
    end
    root = Node.new(arr[arr.length/2])
    root.left = build_tree(arr[0..(arr.length/2)-1])
    root.right = build_tree(arr[(arr.length/2)+1..-1])
    root
  end
  
  def insert(value)
    to_insert = Node.new(value)
    pointer = @root
    added = false
    while added == false
      if to_insert < pointer
        if pointer.left
          pointer = pointer.left
        else
          pointer.left = to_insert
          added = true
        end
      else
        if pointer.right
          pointer = pointer.right
        else
          pointer.right = to_insert
          added = true
        end
      end
    end
  end
  
  def delete(value)
    #if no children. done
    #if 1 child. push up rightmost child if on left or leftmost child if on right
    #if 2 children. push rightmost child of left or leftmost child of right
    pointer = @root

  end
  
  def find(value)
    pointer = @root
    while pointer.data != value         # assumes value is in the tree rn
      if value < pointer.data
        pointer = pointer.left
      else
        pointer = pointer.right
      end
    end
    pointer
  end
  
  def level_order
    #bfs
    arr = []
    arr.push(@root)
    while arr.length > 0
      temp = arr[0]
      yield(temp)
      arr = arr[1..-1]
      if temp.left
        arr.push(temp.left)
      end
      if temp.right
        arr.push(temp.right)
      end
    end
  end
  
  def inorder
    #left,root,right
    if !self.root
      return
    end
    self.inorder(self.root.left)
    yield(self.root)
    self.inorder(self.root.right)
  end
  
  def preorder
    #root,left,right
    if !self.root
      return
    end
    yield(self.root)
    self.preorder(self.root.left)
    self.preorder(self.root.right)
  end
  
  def postorder
    #left,right,root
    if !self.root
      return
    end
    self.postorder(self.root.left)
    self.postorder(self.root.right)
    yield(self.root)
  end
  
  def height(node)
    pointer = @root
    while pointer != node
      if node < pointer
        pointer = pointer.left
      else
        pointer = pointer.right
      end 
    end
    h = 0
    while pointer.is_leaf? == false #need to find longest path
      pointer = pointer.left
      h += 1
    end
    h
  end
  
  def depth(node)
    pointer = @root
    d = 0
    while pointer != node
      if node < pointer
        pointer = pointer.left
      else
        pointer = pointer.right
      end
      d += 1
    end
    d
  end
  
  def balanced?
  
  end
  
  def rebalance
  
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