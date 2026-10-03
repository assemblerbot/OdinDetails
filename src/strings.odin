package src
import "core:unicode/utf8"
import "core:strings"

// rune -----------------------------------------------------
rune_to_string :: proc(r : rune, allocator := context.allocator) -> string {
	buffer,n := utf8.encode_rune(r)
	return strings.clone(string(buffer[:n]), allocator)
}

// string ---------------------------------------------------

// cstring ---------------------------------------------------
cstring_to_byte :: proc(str : cstring, index : int) -> u8 {
	return (cast([^]u8)str)[index]
}

// []u8 buffer ---------------------------------------------------
buffer_to_string :: proc(buffer : []u8) -> string {
	return strings.string_from_null_terminated_ptr(&buffer[0], len(buffer))
}

buffer_to_cstring :: proc(buffer : []u8) -> cstring {
	return cstring(&buffer[0])
}
