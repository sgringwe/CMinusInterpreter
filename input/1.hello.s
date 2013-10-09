	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0:	.string	"main"
	.comm _gp, 0, 4
	.text
	.globl main
	.type main,@function
main:   nop
	pushq %rbp
	movq %rsp, %rbp
	movq $_gp, %rbx
	addq $-1, %rbx
	movl (%rbx), %eax
	movl $.string_const0, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	leave
	ret
