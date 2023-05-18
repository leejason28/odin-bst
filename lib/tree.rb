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
    pointer = @root                         #check if root has this value. if not, check children before traversing the tree
    while pointer.data != value
      if value < pointer.data
        pointer = pointer.left
      else
        pointer = pointer.right
      end
    end

    if pointer.is_leaf?
      pointer = nil                        #need to let parent know that child is nil!!! this doesnt do shit.
    else
      temp = pointer
      if pointer.left.is_leaf?
        pointer = pointer.left
        pointer.right = temp.right
      elsif pointer.right.is_leaf?
        pointer = pointer.right
        pointer.left = temp.left
      else
        pointer = pointer.left
        pointer.right = temp.right
        pointer.left = temp.left.left
        pointer.left.right = temp.left.right
      end
    end
  end
  
  def find(value)
  
  end
  
  def level_order
  
  end
  
  def inorder
  
  end
  
  def preorder
  
  end
  
  def postorder
  
  end
  
  def height(node)
  
  end
  
  def depth(node)
  
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