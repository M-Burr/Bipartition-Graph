#breath-first
def puppy_checker(node, pink, blue)
  if pink.include?(node)
    return "pink"
  elsif blue.include?(node)
    return "blue"
  else
    return "uncolored"
  end
end

def possible_bipartition(dislikes)
  pink = Set.new
  blue = Set.new 
  
  dislikes.each_with_index do |adjacent_nodes , i|
    node_color = puppy_checker(i, pink, blue)
    if node_color == "pink"
      pink << i 
    else
      blue << i
      node_color = "blue"
    end 
    
    adjacent_nodes.each do |j|
      adjacent_color = puppy_checker(j, pink, blue)
      return false if node_color == adjacent_color
      if node_color == "pink"
        blue << j
      else
        pink << j
      end
    end
  end 
  
  return true
end

def possible_bipartition_2(dislikes)
  pink = Set.new
  blue = Set.new 
  
  boolean_array = []
  dislikes.each_with_index do |adjacent_nodes, i|
    boolean_array << sub_tree_helper(i, pink, blue, dislikes, nil)
  end
  
  if boolean_array.all?
    return true 
  else
    return false
  end
end

#depth-first
def sub_tree_helper(node, pink, blue, dislikes, parent_color)
  if parent_color == "pink" && pink.include?(node)
    return false 
  elsif parent_color == "blue" && blue.include?(node)
    return false 
  elsif parent_color == "pink" && blue.include?(node)
    return true 
  elsif parent_color == "blue" && pink.include?(node)
    return true
  end
  
  parent_node = puppy_checker(node, pink, blue)
  if parent_node == "pink"
    pink << parent_node
  else 
    blue << parent_node
  end
  
  
  boolean_array = []
  dislikes[node].each_with_index do |adjacent_node, i|
    boolean_array << sub_tree_helper(i, pink, blue, dislikes, parent_node)
  end
  
  if boolean_array.all?
    return true
  else
    return false
  end
end
