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
	addq $0, %eax
	movl (%eax), %edi
	movq $_gp,%rbx
	addq $5, rbx
	movl (%rbx), %eax	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r8d
	movq $_gp,%rbx
	addq $6, rbx
	movl (%rbx), %eax	movl %eax, %eax
	movl %eax, %r9d
	movl $0, %r10d
	movl $.int_wformat, %r11d
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r9d
	movq $_gp,%rbx
	addq $7, rbx
	movl (%rbx), %eax	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r10d
	movq $_gp,%rbx
	addq $8, rbx
	movl (%rbx), %eax	movl %ebx, %eax
	movl %eax, %r11d
	movl $0, %r12d
	movl $.int_wformat, %r13d
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %r11d
	movq $_gp,%rbx
	addq $9, rbx
	movl (%rbx), %eax	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r12d
	movq $_gp,%rbx
	addq $10, rbx
	movl (%rbx), %eax	movl %eax, %eax
	movl %eax, %r13d
	movl $0, %r14d
	movl $.int_wformat, (null)
	call printf
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r13d
	movq $_gp,%rbx
	addq $11, rbx
	movl (%rbx), %eax	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r14d
	movq $_gp,%rbx
	addq $12, rbx
	movl (%rbx), %eax	movl %ebx, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	leave
	ret
