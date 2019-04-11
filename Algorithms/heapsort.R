### 1. CREATING A HEAP ###

heapify <- function(array) {
    # min-heap implementation
    array <- - array

    heap_len <- length(array)
    start <- round(heap_len %/% 2)  # integer division
    
    while (start >= 1) {
        i <- start
        
        while ((i * 2) <= heap_len) {
            child <- i * 2
            if ((child + 1 <= heap_len) & (array[child] < array[child + 1])) {
                child <- child + 1
            }
            if (array[i] < array[child]) {
                tmp <- array[i]
                array[i] <- array[child]
                array[child] <- tmp
                i <- child
            } else {break}
        }
        start <- start - 1
    }
    array <- -array
return(array)
}


### 2. HEAP SORT ###

heapsort <- function(array, sorted_list=c()) {
    
    array_len = length(array)
    
    for (i in 1:array_len) {
        
        tmp <- array[1]
        array[1] <- array[array_len - i + 1]
        array[array_len - i + 1] <- tmp
        
        sorted_list <- c(sorted_list, array[array_len - i + 1])
        
        array <- head(array, -1)
        array <- heapify(array)
    }

    return(sorted_list)
}


### 3. EXAMPLES ###

# 1

# time
start_time <- Sys.time()

array <- sample(1:51, 20)  # random vector
array <- heapify(array)
heapsort(array)

# time
Sys.time() - start_time

# 2

# time
start_time <- Sys.time()

array1 <- c(16, 17, 27, 26, 32, 19, 41, 3, 33, 38, 49, 47, 6, 12, 22, 11, 13, 48, 4)
array1 <- heapify(array1)
heapsort(array1)

# time
Sys.time() - start_time
