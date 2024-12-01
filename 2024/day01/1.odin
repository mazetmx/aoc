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

	// Compute the distances
	total_distance : int
	
	for _, index in left_list {
		total_distance += abs(left_list[index] - right_list[index])
	}

	// Print the result
	fmt.println(total_distance) // -> 2031679
}