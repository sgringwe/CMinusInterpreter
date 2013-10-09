	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0:	.string	"a"
	.comm _gp, 4, 4
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
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %edx
	movq $_gp, %rbx
	addq $-1, %rbx
	movl (%rbx), %esi
	movq $_gp, %rbx
	addq $-1, %rbx
	movl (%rbx), %edi
	movq $_gp, %rbx
	addq $-1, %rbx
	movl (%rbx), %r8d
	movq $_gp, %rbx
	movq $-1, %rbx
	movl (%rbx), %edi
	movq $_gp, %rbx
	movq $-1, %rbx
	movl (%rbx), %r8d
	addl %edi, %r8d
	leave
	ret
