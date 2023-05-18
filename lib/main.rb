require_relative './node'
require_relative './tree'

arr = [1,7,4,23,8,9,3]
t = Tree.new(arr)
p t
t.insert(10)
p t
t.insert(12)
p t