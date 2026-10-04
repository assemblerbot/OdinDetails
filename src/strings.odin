package src
import "core:unicode/utf8"
import "core:strings"
import "core:mem"

// note:
//  - cbuffer in this file means []u8 buffer of fixed size that is filled with characters from the start up to first zero and rest is filled with zeroes
//  - there is always at least one zero at the end of cbuffer!
//  - useful for C libraries that expect fixed buffer for strings (usually string editors, etc..)

// rune -----------------------------------------------------
rune_to_string :: proc(r : rune, allocator := context.allocator) -> string {
	buffer,n := utf8.encode_rune(r)
	return strings.clone(string(buffer[:n]), allocator)
}

// string ---------------------------------------------------
copy_string_to_cbuffer :: proc(str : string, cbuffer : []u8) {
	mem.set(&cbuffer[0], 0, len(cbuffer))
	mem.copy(&cbuffer[0], raw_data(str), min(len(str), len(cbuffer)-1))
}

// cstring ---------------------------------------------------
cstring_to_byte :: proc(str : cstring, index : int) -> u8 {
	return (cast([^]u8)str)[index]
}

// cbuffer ---------------------------------------------------
cbuffer_to_string :: proc(cbuffer : []u8) -> string {
	return strings.string_from_null_terminated_ptr(&cbuffer[0], len(cbuffer))
}

cbuffer_to_cstring :: proc(cbuffer : []u8) -> cstring {
	return cstring(&cbuffer[0])
}
