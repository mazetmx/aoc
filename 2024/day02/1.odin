package main

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
    // Open file and read data
    data, ok := os.read_entire_file("1.txt", context.allocator)
    if !ok {
        fmt.println("Error while reading file")
    }
    defer delete(data, context.allocator)

    // Reports array
    reports : [1000][dynamic]int = {}

    // Popuelate the reports array
    file_contnets := string(data)
    z := 0
    for line in strings.split_lines_iterator(&file_contnets) {
        strs := strings.split(line, " ", context.allocator)
        for num_str, j in strs {
            //reports[z][j], _ = strconv.parse_int(num)
            num, _ := strconv.parse_int(num_str)
            append(&reports[z], num)
        }
        z += 1
    }

    // Process the reports
    // make sure the report is either increasing or decreasing only (may need to sort them and check)
    // make sure that the differences if between 1 inclusive and 3 inclusive (this is the easy part)
    accum : int
    for rep, i in reports {
        foo := rep
        sorted_flag := slice.is_sorted(foo[:])
        slice.reverse(foo[:])
        rev_sorted_flag := slice.is_sorted(foo[:])
        if !(sorted_flag || rev_sorted_flag) {
            continue
        }

        max_diff := 0
        min_diff := 100
        for num, j in rep {
            if (j == 0) {
                continue
            }

            diff := abs(num - rep[j-1])
            if (diff > max_diff) {
                max_diff = diff
            }
            if (diff < min_diff) {
                min_diff = diff
            }
        }
        if max_diff > 0 && max_diff < 4 && min_diff > 0{
             accum += 1
        }
    }

    // Print the result
    fmt.println(accum) // -> 670
}