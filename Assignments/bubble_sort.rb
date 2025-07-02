def bubble_sort(arr)
    array = arr.dup
    n = array.length

    loop do
        swapped = false

        (n - 1).times do |i|
            if array[i] > array[i + 1]
                array[i], array[i + 1] = array[i + 1], array[i]
                swapped = true
            end
        end

        break unless swapped
    end

puts bubble_sort([4, 2, 2, 2, 2, 1])