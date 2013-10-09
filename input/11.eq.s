	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 16, 4
	.text
	.globl main
	.type main,@function
main:   nop
	pushq %rbp
	movq %rsp, %rbp
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %eax
	movq $_gp, %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	movq $_gp, %rbx
	addq $0, %rbx
	movl $4, %edx
	movl %edx, (%rbx)
	movq $_gp, %rbx
	addq $4, %rbx
	movl (%rbx), %edx
	movq $_gp, %rbx
	addq $8, %rbx
	movl (%rbx), %esi
	movq $_gp, %rbx
	addq $8, %rbx
	movl $12, %edi
	movl %edi, (%rbx)
	movq $_gp, %rbx
	addq $8, %rbx
	movl (%rbx), %edi
	movq $_gp, %rbx
	addq $12, %rbx
	movl (%rbx), %r8d
	movq $_gp, %rbx
	addq $-1, %rbx
	movl $-1, %r9d
	movl %r9d, (%rbx)
	movq $_gp, %rbx
	addq $12, %rbx
	movl (%rbx), %r9d
	movq $_gp, %rbx
	addq $-1, %rbx
	movl (%rbx), %r10d
	movq $_gp, %rbx
	addq $-1, %rbx
	movl $-1, %r11d
	movl %r11d, (%rbx)
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %r11d
	movq $_gp, %rbx
	addq $4, %rbx
	movl (%rbx), %r12d
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %r13d
	movq $_gp, %rbx
	addq $0, %rbx
	movl (%rbx), %r14d
	movq $_gp, %rbx
	addq $8, %rbx
	movl (%rbx), (null)
	movq $_gp, %rbx
	addq $8, %rbx
	movl (%rbx), (null)
	movq $_gp, %rbx
	addq $8, %rbx
	movl (%rbx), (null)
	movq $_gp, %rbx
	addq $12, %rbx
	movl (%rbx), (null)
	leave
	ret
