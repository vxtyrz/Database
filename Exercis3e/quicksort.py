array1 = [5, 3, 15, 7, 13, 22]

def partition(array, start, end):
    pivot = array[end]
    i = start

    for j in range(start, end):
        if array[j] < pivot:
            array[i], array[j] = array[j], array[i]
            i += 1
    array[i], array[end] = array[end], array[i]
    return i 

def quick_sort (array, start, end):
    if start < end:
        position = partition(array, start, end)
        quick_sort(array, start, position - 1) #left
        quick_sort(array, position + 1, end) #right
    return array

sorted_array = quick_sort(array1, 0, len(array1) - 1)
print(sorted_array)