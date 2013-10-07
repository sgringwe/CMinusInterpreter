	.section        .rodata

movq $_gp,%rbx
addq $0, %rbx
movl $1, %ecx
movl %ecx, (%rbx)
movq $_gp,%rbx
addq $0, %rbx
movl $0, %ecx
movl %ecx, (%rbx)
movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
movl $7, %ebx
movl %ebx, %esi
movl $0, %eax
movl $.int_wformat, %edi
call printf
	leave
	ret

var count 2