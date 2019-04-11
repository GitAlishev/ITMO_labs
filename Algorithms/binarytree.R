### 1. CREATING AND OUTPUTTING THE TREE ###

	# Create binary tree with node as root
	binary_tree <- function(node) {
	    return(list(node, list(), list()))
	}

	# Create left subtree for current node or tree
	insert_left <- function(tree, node) {
	    tree[[2]] <- list(node, list(), list())
	    return(tree)
	}

	# Create right subtree for current node or tree
	insert_right <- function(tree, node) {
	    tree[[3]] <- list(node, list(), list())
	    return(tree)
	}

	# Get the root node
	get_root_node <- function(tree) {
	    return(tree[[1]])
	}

	# Get the left child of the tree
	get_left_child <- function(tree) {
	    return(tree[[2]])
	}

	# Get the right child of the tree
	get_right_child <- function(tree) {
	    return(tree[[3]])
	}


	# Example
	tree <- binary_tree('E')
	tree <- insert_left(tree, 'B')
	tree <- insert_right(tree, 'F')
	tree[[2]] <- insert_left(get_left_child(tree), 'A')
	tree[[2]] <- insert_right(get_left_child(tree), 'D')
	tree[[2]][[3]] <- insert_left(get_right_child(get_left_child(tree)), 'C')
	tree[[3]] <- insert_right(get_right_child(tree), 'I')
	tree[[3]][[3]] <- insert_left(get_right_child(get_right_child(tree)), 'G')
	tree[[3]][[3]] <- insert_right(get_right_child(get_right_child(tree)), 'J')
	tree[[3]][[3]][[2]] <- insert_right(get_left_child(get_right_child(get_right_child(tree))), 'H')

	tree


### 2. MANUAL TREE TRAVERSAL """

	# Breadth-first search order
	tree_list <- list(
	    get_root_node(tree),
	    get_root_node(get_left_child(tree)),
	    get_root_node(get_right_child(tree)),
	    get_root_node(get_left_child(get_left_child(tree))),
	    get_root_node(get_right_child(get_left_child(tree))),
	    get_root_node(get_right_child(get_right_child(tree))),
	    get_root_node(get_left_child(get_right_child(get_left_child(tree)))),
	    get_root_node(get_left_child(get_right_child(get_right_child(tree)))),
	    get_root_node(get_right_child(get_right_child(get_right_child(tree)))),
	    get_root_node(get_right_child(get_left_child(get_right_child(get_right_child(tree)))))
	)

	tree_list

	# Result: E B F A D I C G J H


### 3. DRAW THE TREE ###

	library(data.tree)

	# root node
	tr <- Node$new(tree_list[[1]])

	# next level
	level1_left <- tr$AddChild(tree_list[[2]])
	level1_right <- tr$AddChild(tree_list[[3]])

	# next level
	level2_left <- level1_left$AddChild(tree_list[[4]])
	level2_right1 <- level1_left$AddChild(tree_list[[5]])
	level2_right2 <- level1_right$AddChild(tree_list[[6]])

	# next level
	level2_right1$AddChild(tree_list[[7]])  # leaf
	level3_left <- level2_right2$AddChild(tree_list[[8]])
	level2_right2$AddChild(tree_list[[9]])  # leaf

	# next level
	level3_left$AddChild(tree_list[[10]])  # leaf

	# simple image
	print(tr)
	
	# Pre-order tree traversal with an R function
	Traverse(tr, traversal='pre-order')

# time
start_time <- Sys.time()

	# tree image
	plot(tr)

# time
Sys.time() - start_time
