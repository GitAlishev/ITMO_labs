### 1. MERGE SORT ###

mergesort <- function(array) {
    
    n <- length(array)
    if (n < 2) {return(array)}

    mid = n %/% 2

    left <- array[1:mid]
    right <- array[(mid + 1):n]

    left <- mergesort(left)
    right <- mergesort(right)

    sorted_list <- c()
    i <- 0

    while (length(left) > 0 && length(right) > 0) {

        if (left[1] < right[1]) {
            sorted_list[i + 1] <- left[1]
            left <- tail(left, -1)
        } else {
            sorted_list[i + 1] <- right[1]
            right <- tail(right, -1)
        }

        i <- i + 1
    }

    sorted_list <- c(sorted_list, left, right)
    return(sorted_list)
}


### 2. EXAMPLES ###

# time
start_time <- Sys.time()

array <- sample(1:51, 20)
mergesort(array)

# time
Sys.time() - start_time
