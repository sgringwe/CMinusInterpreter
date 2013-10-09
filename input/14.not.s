	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 8, 4
	.text
	.globl main
	.type main,@function
main:   nop
	pushq %rbp
	movq %rsp, %rbp
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %ebx
	movq $_gp,%rbx
	addq $0, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %ecx
	movq $_gp,%rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %edx
	movl %edx, %eax
	movl %eax, %esi
	movl $0, %edi
	movl $.int_wformat, %r8d
	call printf
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %edx
	movl %eax, %eax
	movl %eax, %esi
	movl $0, %edi
	movl $.int_wformat, %r8d
	call printf
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %esi
	movl %esi, %eax
	movl %eax, %edi
	movl $0, %r8d
	movl $.int_wformat, %r9d
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %esi
	movl %eax, %eax
	movl %eax, %edi
	movl $0, %r8d
	movl $.int_wformat, %r9d
	call printf
	leave
	ret
