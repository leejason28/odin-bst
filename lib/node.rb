class Node 

  include Comparable

  def <=>(other)
    self.data <=> other.data
  end

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def is_leaf?
    if !self.left && !self.right
      return true
    end
    return false
  end

end