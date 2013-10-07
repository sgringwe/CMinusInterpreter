	.section        .rodata

movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
movq $_gp,%rbx
addq $0, %rbx
movl $7, %ecx
movl %ecx, (%rbx)
movq $_gp,%rbx
addq $0, %rbx
movl $3, %ecx
movl %ecx, (%rbx)
movq $_gp,%rbx
addq $0, %rbx
movl $4, %ecx
movl %ecx, (%rbx)
movq $_gp,%rbx
addq $0, %rbx
movl $-1, %ecx
movl %ecx, (%rbx)
movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
	leave
	ret

var count 4