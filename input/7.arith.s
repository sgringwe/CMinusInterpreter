	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 20, 4
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
	movl 	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r11d
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %r12d
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r13d
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r14d
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), (null)
	movl %r10d, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	leave
	ret
