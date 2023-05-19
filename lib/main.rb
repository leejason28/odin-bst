require_relative './node'
require_relative './tree'

arr = Array.new(15) { rand(1..100) }
p arr
t = Tree.new(arr)
t.pretty_print
p "balanced?:  #{t.balanced?}"
p "level order:"
p t.level_order
p "pre order:"
p t.preorder
p "post order:"
p t.postorder
p "in order:"
p t.inorder
insertion_arr = Array.new(10) { rand(101..200) }
for i in 0...insertion_arr.uniq.length
  t.insert(insertion_arr.uniq[i])
end
p "balanced?:  #{t.balanced?}"
t.rebalance
t.pretty_print
p "level order:"
p t.level_order
p "pre order:"
p t.preorder
p "post order:"
p t.postorder
p "in order:"
p t.inorder