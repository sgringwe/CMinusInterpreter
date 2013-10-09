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
	movl $0, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %edx
	movq $_gp,%rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %esi
	movq $_gp,%rbx
	addq $0, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %edi
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r8d
	movl %ebx, %eax
	movl %eax, %r9d
	movl $0, %r10d
	movl $.int_wformat, %r11d
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %ebx
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r9d
	movl %ebx, %eax
	movl %eax, %r10d
	movl $0, %r11d
	movl $.int_wformat, %r12d
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %ebx
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r10d
	movl %ebx, %eax
	movl %eax, %r11d
	movl $0, %r12d
	movl $.int_wformat, %r13d
	call printf
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %ebx
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r11d
	movl %ebx, %eax
	movl %eax, %r12d
	movl $0, %r13d
	movl $.int_wformat, %r14d
	call printf
	leave
	ret
