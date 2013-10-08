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
	movq $_gp,%rbx
	addq $3, rbx
	movl (%rbx), %eax	movl (null), %eax
	movl %eax, %esi
	movl $0, %edi
	movl $.int_wformat, %r8d
	call printf
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %esi
	movq $_gp,%rbx
	addq $4, rbx
	movl (%rbx), %eax	movl %eax, %eax
	movl %eax, %edi
	movl $0, %r8d
	movl $.int_wformat, %r9d
	call printf
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %edi
	movq $_gp,%rbx
	addq $5, rbx
	movl (%rbx), %eax	movl (null), %eax
	movl %eax, %r8d
	movl $0, %r9d
	movl $.int_wformat, %r10d
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r8d
	movq $_gp,%rbx
	addq $6, rbx
	movl (%rbx), %eax	movl %eax, %eax
	movl %eax, %r9d
	movl $0, %r10d
	movl $.int_wformat, %r11d
	call printf
	leave
	ret
