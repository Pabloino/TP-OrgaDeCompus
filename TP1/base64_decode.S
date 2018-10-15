#include <mips/regdef.h>
#include <sys/syscall.h>

#define STACK_FRAME_SIZE 32

.text
.abicalls
.align 2

.globl 		base64_decode
.ent 		base64_decode

.set 		noreorder
.cpload 	t9
.set 		reorder

base64_decode:	
    subu 	sp,  sp, STACK_FRAME_SIZE

    sw      gp,  (STACK_FRAME_SIZE - 24)(sp)
	sw 	    $fp, (STACK_FRAME_SIZE - 20)(sp)
	sw 	    ra,  (STACK_FRAME_SIZE - 16)(sp)
    sw      s2,  (STACK_FRAME_SIZE - 12)(sp)
    sw      s3,  (STACK_FRAME_SIZE - 8)(sp)

	move    $fp, sp

	sw 	    a0,  (STACK_FRAME_SIZE     )(sp)
	sw 	    a1,  (STACK_FRAME_SIZE +  4)(sp)

read_input:

	lw	    a0, (STACK_FRAME_SIZE)(sp)
	la	    a1, input_buffer
	li	    a2, 1
	li	    v0, SYS_read
	syscall

    beq     a3, zero, continue_validation 
    li      v0, 1
    j       exit_base64_decode
    

continue_validation:
    li      s2, 0                     # Read byte count
    addu    s2, s2, v0
        
    bne     s2, zero, continue_read
    li      v0, 0
    j       exit_base64_decode

continue_read:
	lw	    a0, (STACK_FRAME_SIZE)(sp)
	la	    a1, input_buffer + 1
	li	    a2, 1
	li	    v0, SYS_read
	syscall

    beq     a3, zero, continue_second_validation
    li      v0, 1
    j       exit_base64_decode
    
continue_second_validation:
    addu    s2, s2, v0

    lw      a0, (STACK_FRAME_SIZE)(sp)
	la	    a1, input_buffer + 2
	li	    a2, 1
	li	    v0, SYS_read
	syscall

    beq     a3, zero, continue_third_validation
    li      v0, 1
    j       exit_base64_decode

continue_third_validation:
    addu    s2, s2, v0

    lw	    a0, (STACK_FRAME_SIZE)(sp)
    la	    a1, input_buffer + 3
    li	    a2, 1
    li	    v0, SYS_read
    syscall
    
    beq     a3, zero, continue_fourth_validation
    li      v0, 1
    j       exit_base64_decode
    
continue_fourth_validation:    
    addu    s2, s2, v0
        
    li      t1, 4                   
    beq     s2, t1, assert_buffer   # Read_byte_count == 4 ?
        
    li      v0, 2                   # ERR: Wrong encoded msg length
    j       exit_base64_decode
	
assert_buffer:

    li      s3, 0                   # Count for '='

    la      t0, input_buffer        # t0 = input
    lbu     t1, 0(t0)               # t1 = input[0]
    li      t2, '='
    beq     t1, t2, assert_err      # input[0] == '=' ?

    lbu     t1, 1(t0)               # t1 = input[1]
    beq     t1, t2, assert_err      # input[1] == '=' ?

    lbu     t1, 2(t0)               # t1 = input[2]
    bne     t1, t2, count_pad       # input[2] != '=' ?

    lbu     t1, 3(t0)               # t1 = input[3]
    beq     t1, t2, count_pad       # input[3] == '=' ?

assert_err:
    
    li      v0, 2                   # ERR: Wrong encoded msg length
    j       exit_base64_decode

count_pad:
        la      t0, input_buffer
        li      t4, '='
        lbu     t1, 3(t0)               # t1 = input[3]
        
        bne     t1, t4, assert_ok
        addiu   s3, s3, 1
        lbu     t1, 2(t0)
        bne     t1, t4, assert_ok
        addiu   s3, s3, 1
        
assert_ok:
        j       decode

## The following is an impl of tp0:decode_char
## Args:
##      a1: base64_symbol
##      a2: where to write recovered symbol 

recover_symbol:

        li      t0, 26                  # BASE_64_INDEX_a
        li      t1, 52                  # BASE_64_INDEX_0
        
        la      t2, input_buffer        #

a_range:
        li      t4, 'a'                 #
        bltu    a1, t4, A_range         # branch to A_range ?
        subu    a1, a1, t4              # a1 -= 'a'
        addu    a1, a1, t0              # a1 += BASE_64_INDEX_a
        j       end_recover

A_range:
        li      t4, 'A'                 #
        bltu    a1, t4, z_range         # branch to z_range ?          
        subu    a1, a1, t4              # a1 -= 'A'         
        j       end_recover

z_range:
        li      t4, '0'                 #                             
        bltu    a1, t4, assert_symbol   # branch to assert_symbol ?
        subu    a1, a1, t4              # a1 -= '0'
        addu    a1, a1, t2              # a1 += BASE_64_INDEX_0
        j       end_recover

assert_symbol:
        li      t4, '/'                 # if a1 != '/'
        beq     a1, t4, end_assert
        li      t4, '+'                 # && a1 != '+'
        beq     a1, t4, end_assert
        li      t4, '='                 # && a1 != '='
        beq     a1, t4, end_assert

        li      v0, 3                   # ERR: Cannot decode symbol
        j       exit_base64_decode

end_assert:
        li      a1, 62                  # a1 = 62 + base_symbol == '/'
        li      t4, '/'
        bne     a1, t4, end_recover     
        addu    a1, a1, 1       
        li      t4, '='                 # a1 = 0 if equals to '='
        bne     a1, t4, end_recover
        li      a1, 0

end_recover:
        sb      a1, 0(a2)               # output[a2] = a1
        jr      ra

## end tp0:decode_char
##

decode:
        la      a2, input_buffer        # a2 = input
        lbu     a1, 0(a2)               # a1 = input[0]
        la      ra, recover_1
        j       recover_symbol
recover_1:       
        addiu   a2, a2, 1               # a2 = input + 1
        lbu     a1, 0(a2)               # a1 = input[1]
        la      ra, recover_2
        j       recover_symbol
recover_2:
        addiu   a2, a2, 1               # a2 = input + 2
        lbu     a1, 0(a2)               # a1 = input[2]
        la      ra, recover_3
        j       recover_symbol
recover_3:
        addiu   a2, a2, 1               # a2 = input + 3
        lbu     a1, 0(a2)               # a1 = input[3]
        la      ra, recover_4
        j       recover_symbol
recover_4:    
        la      t0, input_buffer        # t0 = input 
        la      t3, output_buffer       # t3 = output

        lbu     t1, 0(t0)               # t1 = input[0]
        lbu     t2, 1(t0)               # t2 = input[1]
        remu    t1, t1, 64              # t1 %= 64
        sll     t1, 2                   # t1 << 2
        srl     t2, 4                   # t2 >> 4
        or      t1, t1, t2              # t1 |= t2
        sb      t1, 0(t3)               # output[0] = t1

        lbu     t1, 1(t0)               # t1 = input[1]
        lbu     t2, 2(t0)               # t2 = input[2]
        remu    t1, t1, 16              # t1 %= 16
        sll     t1, 4                   # t1 << 4
        srl     t2, 2                   # t2 >> 2
        or      t1, t1, t2              # t1 |= t2
        sb      t1, 1(t3)               # output[1] = t1

        lbu     t1, 2(t0)               # t1 = input[2]
        lbu     t2, 3(t0)               # t2 = input[3]
        remu    t1, t1, 4               # t1 %= 4
        sll     t1, 6                   # t1 << 6
        remu    t2, t2, 64              # t2 %= 64
        or      t1, t1, t2              # t1 |= t2
        sb      t1, 2(t3)               # output[2] = t1

write_output:

	lw	a0, (STACK_FRAME_SIZE + 4)(sp)
	la 	a1, output_buffer
	li 	a2, 1
	li 	v0, SYS_write
	syscall
	
    beq a3, 0, continue_write_val
    li  v0, 1
    j   exit_base64_decode
    
continue_write_val:
    li  t0, 2
    beq t0, s3, exit_base64_decode
    
    lw	a0, (STACK_FRAME_SIZE + 4)(sp)
	la 	a1, output_buffer + 1
	li 	a2, 1
	li 	v0, SYS_write
	syscall

    beq a3, 0, continue_second_write_val
    li  v0, 1
    j   exit_base64_decode
    
continue_second_write_val:
    li  t0, 1
    beq t0, s3, exit_base64_decode

	lw	a0, (STACK_FRAME_SIZE + 4)(sp)
	la 	a1, output_buffer + 2
	li 	a2, 1
	li 	v0, SYS_write
	syscall

    beq a3, 0, continue_loop
    li  v0, 1
    j   exit_base64_decode
    
continue_loop:
    j       read_input

exit_base64_decode:
	
	lw  a1,  (STACK_FRAME_SIZE +  4)(sp)
    lw 	a0,  (STACK_FRAME_SIZE	   )(sp)

	lw 	gp,  (STACK_FRAME_SIZE - 24)(sp)
	lw 	$fp, (STACK_FRAME_SIZE - 20)(sp)
	lw 	ra,  (STACK_FRAME_SIZE - 16)(sp)
    lw  s3,  (STACK_FRAME_SIZE - 12)(sp)
    lw  s2,  (STACK_FRAME_SIZE -  8)(sp)

	addu 	sp,  sp, STACK_FRAME_SIZE

	jr 	ra

.end    base64_decode

.data
.align 2

input_buffer:
	.space  4
	.byte 	0, 0, 0, 0
output_buffer:
	.space  3
	.byte 	0, 0, 0

