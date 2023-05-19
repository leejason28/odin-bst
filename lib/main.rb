require_relative './node'
require_relative './tree'

arr = Array.new(15) { rand(1..100) }
p arr
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