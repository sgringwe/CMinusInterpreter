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
	movl $2, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %edx
	movq $_gp,%rbx
	addq $0, %rbx
	movl $3, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %esi
	movq $_gp,%rbx
	addq $0, %rbx
	movl $4, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $16, %eax
	movl (%eax), %edi
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r8d
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r9d
	movq $_gp,%rbx
	addq $0, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $16, %eax
	movl (%eax), %r10d
	movl %ebx, %eax
	movl %eax, %r11d
	movl $0, %r12d
	movl $.int_wformat, %r13d
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %ebx
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r11d
	movl %eax, %eax
	movl %eax, %r12d
	movl $0, %r13d
	movl $.int_wformat, %r14d
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %r12d
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r13d
	movl %ebx, %eax
	movl %eax, %r14d
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %ebx
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r14d
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movl %eax, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	leave
	ret
