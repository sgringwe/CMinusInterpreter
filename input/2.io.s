	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0:	.string	"input an integer:"
	.comm _gp, 4, 4
	.text
	.globl main
	.type main,@function
main:   nop
	pushq %rbp
	movq %rsp, %rbp
	movl $.string_const0, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %ebx
	movq $_gp,%rbx
	addq $4, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %ecx
	movl %ecx, %eax
	movl %eax, %edx
	movl $0, %esi
	movl $.int_wformat, %edi
	call printf
	movl %ebx, %eax
	movl %eax, %ecx
	movl $0, %edx
	movl $.int_wformat, %esi
	call printf
	movl %edx, %eax
	movl %eax, %ebx
	movl $0, %ecx
	movl $.int_wformat, %edx
	call printf
	leave
	ret
