require_relative './node'
require_relative './tree'

arr = Array.new(15) { rand(1..100) }
p arr
l = arr[0..(arr.length/2)-1]
r = arr[(arr.length/2)..-1]
p l
p r
t = Tree.new(arr)
t.pretty_print
p "balanced?: #{t.balanced?}"
p "level order:"
#t.level_order { |node| puts node.data } 
p "pre order:"
p t.preorder
p "post order:"
p t.postorder
p "in order:"
p t.inorder