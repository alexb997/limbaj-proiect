	.text
	.global main
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	$10, %eax
	movl	%eax, value1
	movl	$3, %eax
	imull	value1, %eax
	movl	%eax, _T0
	movl	$1, %eax
	addl	$1, %eax
	movl	%eax, _T1
	movl	_T0, %eax
	cdq
	movl	_T1, %ebx
	idiv	%ebx
	movl	%eax, _T2
	movl	_T2, %eax
	subl	$4, %eax
	movl	%eax, _T3
	movl	_T3, %eax
	movl	%eax, value2
	pushl	$tmpstr0
	pushl	$param3
	call	printf
	addl	$8, %esp
	pushl	value1
	pushl	$param2
	call	printf
	addl	$8, %esp
	pushl	$tmpstr1
	pushl	$param3
	call	printf
	addl	$8, %esp
	pushl	value2
	pushl	$param2
	call	printf
	addl	$8, %esp
	movl	value2, %eax
	cmp 	value1, %eax
	je 	_L0
	pushl	$tmpstr2
	pushl	$param4
	call	printf
	addl	$8, %esp
	movl	value2, %eax
	movl	%eax, value1
	jmp	_L1
_L0:
_L1:
_L2:
	movl	$1, %eax
	cmp 	value1, %eax
	jge 	_L3
	movl	value1, %eax
	subl	$1, %eax
	movl	%eax, _T4
	movl	_T4, %eax
	movl	%eax, value1
	pushl	value1
	pushl	$param2
	call	printf
	addl	$8, %esp
	jmp	_L2
_L3:
_L4:
	movl	value2, %eax
	subl	$1, %eax
	movl	%eax, _T5
	movl	_T5, %eax
	movl	%eax, value2
	pushl	value2
	pushl	$param2
	call	printf
	addl	$8, %esp
	movl	value2, %eax
	cmp 	value1, %eax
	jne 	_L4
	movl	value2, %eax
	cmp 	value1, %eax
	jne 	_L5
	pushl	$tmpstr3
	pushl	$param4
	call	printf
	addl	$8, %esp
	jmp	_L6
_L5:
	pushl	$tmpstr4
	pushl	$param4
	call	printf
	addl	$8, %esp
_L6:
	popl	%edi
	popl	%esi
	popl	%ebx
	movl	%ebp, %esp
	popl	%ebp
	ret	$0

	.data
param1:	.asciz "%d"
param2:	.asciz "%d\n"
param3:	.asciz "%s"
param4:	.asciz "%s\n"
example:	.int 0
input:	.int 0
output:	.int 0
value1:	.int 0
value2:	.int 0
_T0:	.int 0
_T1:	.int 0
_T2:	.int 0
_T3:	.int 0
_T4:	.int 0
_T5:	.int 0
tmpstr0:	.asciz  "Value1 is: "
tmpstr1:	.asciz  "Value2 is: "
tmpstr2:	.asciz  "Values were not same."
tmpstr3:	.asciz  "Values are same."
tmpstr4:	.asciz  "Values are not same."
