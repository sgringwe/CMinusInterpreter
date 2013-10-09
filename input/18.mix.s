	.section        .rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0:	.string	"i = "
.string_const1:	.string	"j = "
.string_const2:	.string	"k = "
.string_const3:	.string	"l = "
.string_const4:	.string	"m = "
	.comm _gp, 24, 4
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
	movl $.string_const1, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %ecx
	movq $_gp,%rbx
	addq $4, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf
	movl $.string_const2, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %edx
	movq $_gp,%rbx
	addq $4, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf
	movl $.string_const3, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %esi
	movq $_gp,%rbx
	addq $4, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf
	movl $.string_const4, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf
	movq $_gp, %eax
	addq $16, %eax
	movl (%eax), %edi
	movq $_gp,%rbx
	addq $4, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf
	movq $_gp, %eax
	addq $20, %eax
	movl (%eax), %r8d
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r9d
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), %r10d
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), %r11d
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r12d
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), %r13d
	movq $_gp,%rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	movq $_gp, %eax
	addq $20, %eax
	movl (%eax), %r14d
	movl %r14d, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), %r14d
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $16, %eax
	movl (%eax), (null)
	movl %eax, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $20, %eax
	movl (%eax), (null)
	movl %eax, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $4, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $0, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $16, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $20, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $12, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $8, %eax
	movl (%eax), (null)
	movq $_gp, %eax
	addq $20, %eax
	movl (%eax), (null)
	movl %eax, %eax
	movl %eax, (null)
	movl $0, (null)
	movl $.int_wformat, (null)
	call printf
	leave
	ret
