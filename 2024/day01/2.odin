package main

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
    // Open file and read data
    data, ok := os.read_entire_file("2.txt", context.allocator)
    if !ok {
        fmt.println("Error while reading file")
    }
    defer delete(data, context.allocator)

    // Location IDs arrays
    left_list : [dynamic]int
    right_list : [dynamic]int

    // Popuelate the two lists
    file_contnets := string(data)
    for line in strings.split_lines_iterator(&file_contnets) {
        ids := strings.split(line, "   ", context.allocator)

        left_id, _ := strconv.parse_int(ids[0])
        right_id, _ := strconv.parse_int(ids[1])

        append(&left_list, left_id)
        append(&right_list, right_id)
    }

    // Sort the lists
    slice.sort(left_list[:])
    slice.sort(right_list[:])

    // take the first element
    // loop over the first array and get how many times this element was repeated
    // go to the second list, see how many times this element was repeated
    // element * repeatitions in the first list * repeatations in the second list

    accum := 0

    for i := 0; i < len(left_list); i += 1 {
        curr_elem := left_list[i]
        left_reps := 0
        right_reps := 0

        for j := 0; j < len(left_list); j += 1 {
            if (left_list[j] == curr_elem) {
                left_reps += 1
            }
        }

        for k := 0; k < len(right_list); k += 1 {
            if (right_list[k] == curr_elem) {
                right_reps += 1
            }
        }

        accum += curr_elem * left_reps * right_reps
    }

    fmt.println(accum) // -> 19678534
}