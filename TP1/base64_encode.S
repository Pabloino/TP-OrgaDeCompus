#include <mips/regdef.h>
#include <sys/syscall.h>

#define STACK_SIZE 24

.text
.abicalls
.align 2

.globl		base64_encode
.ent		base64_encode

.set		noreorder
.cpload		t9
.set		reorder

base64_encode:
	subu	sp,  sp, STACK_SIZE

	sw	gp,  (STACK_SIZE - 16)(sp)
	sw	$fp, (STACK_SIZE - 12)(sp)
	sw	ra,  (STACK_SIZE -  8)(sp)
    sw  s3,  (STACK_SIZE -  4)(sp)
    
	move	$fp, sp

	sw	a0,  (STACK_SIZE     )(sp)
	sw	a1,  (STACK_SIZE +  4)(sp)

read_input:

    la    t0, input
    sb    zero, 0(t0)
    sb    zero, 1(t0)
    sb    zero, 2(t0)

    li    s3, 0

    ## Read 1 char at time avoid endianess problems

	lw	a0, (STACK_SIZE)(sp)
	la	a1, input
	li	a2, 1
	li	v0, SYS_read
	syscall

    beq a3, 0, validation
    li  v0, 1
    j   exit_base64_encode

validation:    

    beqz    v0, exit_base64_encode
    addiu   s3, s3, 1

 	lw	a0, (STACK_SIZE)(sp)
 	la	a1, input + 1
 	li	a2, 1
 	li	v0, SYS_read
 	syscall

    beq a3, 0, validation2
    li v0, 1
    j   exit_base64_encode
    
validation2:
    beqz    v0, encode
    addiu   s3, s3, 1

    lw	a0, (STACK_SIZE)(sp)
    la	a1, input + 2
    li	a2, 1
    li	v0, SYS_read
    syscall

    beq a3, 0, validation3
    li  v0, 1
    j   exit_base64_encode

validation3:
    beqz    v0, encode
    addiu   s3, s3, 1

    beq     v0, 0, exit_base64_encode
    addu    s0, v0, 0

	bne			v0, -1, encode
	li			v0, 1

encode:

	la	t0, input
	la	t1, output

	lbu	t2, 0(t0) 		
	srl 	t2, 2 			
	sb  	t2, 0(t1)		

	lbu 	t2, 0(t0)		
	lbu 	t3, 1(t0)		
	remu 	t2, t2, 4		
	sll 	t2, 4			
	srl 	t3, 4			
	or 	t2, t2, t3		
	sb	t2, 1(t1)	

	lbu	t2, 1(t0)		
	lbu	t3, 2(t0)		
	remu	t2, t2, 16		
	sll	t2, 2			
	srl	t3, 6			
	or	t2, t2, t3	
	sb	t2, 2(t1)		

	lbu	t2, 2(t0)		
	remu	t2, t2, 64		
	sb	t2, 3(t1)		

translate_to_symbols:

	la	t0, base64chars
	la	t1, output	
	lbu	t2, 0(t1)		
	addu	t0, t0, t2		
	lb	t0, 0(t0)		
	sb	t0, 0(t1)		

	la	t0, base64chars	
	la	t1, output	
	lbu	t2, 1(t1)		
	addu	t0, t0, t2		
	lb	t0, 0(t0)		
	sb	t0, 1(t1)		

	la	t0, base64chars	
	la	t1, output	
	lbu	t2, 2(t1)		
	addu	t0, t0, t2		
	lb	t0, 0(t0)		
	sb	t0, 2(t1)		

	la	t0, base64chars	
	la	t1, output	
	lbu	t2, 3(t1)		
	addu	t0, t0, t2		
	lb	t0, 0(t0)		
	sb	t0, 3(t1)		

complete_padding:
    li      t0, 0
    beq     s3, t0, write_output
    li      t0, 3
    beq     s3, t0, write_output

    li      t0, '='
    la      t1, output
    sb      t0, 3(t1)

    li      t2, 2
    beq     s3, t2, write_output

    sb      t0, 2(t1)


write_output:

	lw	a0, (STACK_SIZE + 4)(sp)
	la	a1, output
	li	a2, 1
	li	v0, SYS_write
	syscall

    beq a3, 0, write_value
    li  v0, 1
    j   exit_base64_encode

write_value:    

	lw	a0, (STACK_SIZE + 4)(sp)
	la	a1, output + 1
	li	a2, 1
	li	v0, SYS_write
	syscall

    beq a3, 0, write_value2
    li  v0, 1
    j   exit_base64_encode
    
write_value2:    
	lw	a0, (STACK_SIZE + 4)(sp)
	la	a1, output + 2
	li	a2, 1
	li	v0, SYS_write
	syscall

    beq a3, 0, write_value3
    li  v0, 1
    j   exit_base64_encode

write_value3:
	lw	a0, (STACK_SIZE + 4)(sp)
	la	a1, output + 3
	li	a2, 1
	li	v0, SYS_write
	syscall

    beq a3, 0, write_value4
    li  v0, 1
    j   exit_base64_encode
    
write_value4:
    li     t0, 3
    bge    t0, s3, read_input

exit_base64_encode:
	lw	a1,  (STACK_SIZE +  4)(sp)
	lw	a0,  (STACK_SIZE     )(sp)

	lw	gp,  (STACK_SIZE - 16)(sp)
	lw	$fp, (STACK_SIZE - 12)(sp)
	lw	ra,  (STACK_SIZE -  8)(sp)
    lw  s3,  (STACK_SIZE -  4)(sp)

	addu	sp,  sp, STACK_SIZE

	jr	ra

.end		base64_encode

.data
.align 2

input:
	.space	3
	.byte	0, 0, 0
output:
	.space	4
	.byte	0, 0, 0, 0
