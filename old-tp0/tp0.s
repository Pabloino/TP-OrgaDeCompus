	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.globl	encode_table
	.data
	.align	2
	.type	encode_table, @object
	.size	encode_table, 64
encode_table:
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	97
	.byte	98
	.byte	99
	.byte	100
	.byte	101
	.byte	102
	.byte	103
	.byte	104
	.byte	105
	.byte	106
	.byte	107
	.byte	108
	.byte	109
	.byte	110
	.byte	111
	.byte	112
	.byte	113
	.byte	114
	.byte	115
	.byte	116
	.byte	117
	.byte	118
	.byte	119
	.byte	120
	.byte	121
	.byte	122
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	43
	.byte	47
	.globl	options
	.align	2
	.type	options, @object
	.size	options, 12
options:
	.word	0
	.word	1
	.byte	0
	.space	3
	.globl	PADDING_SYMBOL
	.type	PADDING_SYMBOL, @object
	.size	PADDING_SYMBOL, 1
PADDING_SYMBOL:
	.byte	61
	.rdata
	.align	2
$LC0:
	.ascii	"Decoding error: Cannot decode symbol %c\n\000"
	.text
	.align	2
	.globl	decode_char
	.ent	decode_char
decode_char:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,24($fp)
	li	$2,26			# 0x1a
	sb	$2,25($fp)
	li	$2,52			# 0x34
	sb	$2,26($fp)
	lb	$2,24($fp)
	slt	$2,$2,97
	bne	$2,$0,$L18
	lbu	$3,24($fp)
	lbu	$2,25($fp)
	addu	$2,$3,$2
	addu	$2,$2,-97
	sll	$2,$2,24
	sra	$2,$2,24
	sw	$2,28($fp)
	b	$L17
$L18:
	lb	$2,24($fp)
	slt	$2,$2,65
	bne	$2,$0,$L19
	lbu	$2,24($fp)
	addu	$2,$2,-65
	sll	$2,$2,24
	sra	$2,$2,24
	sw	$2,28($fp)
	b	$L17
$L19:
	lb	$2,24($fp)
	slt	$2,$2,48
	bne	$2,$0,$L20
	lbu	$3,24($fp)
	lbu	$2,26($fp)
	addu	$2,$3,$2
	addu	$2,$2,-48
	sll	$2,$2,24
	sra	$2,$2,24
	sw	$2,28($fp)
	b	$L17
$L20:
	lb	$3,24($fp)
	li	$2,47			# 0x2f
	beq	$3,$2,$L21
	lb	$3,24($fp)
	li	$2,43			# 0x2b
	beq	$3,$2,$L21
	lb	$3,24($fp)
	li	$2,61			# 0x3d
	beq	$3,$2,$L21
	lb	$2,24($fp)
	la	$4,__sF+176
	la	$5,$LC0
	move	$6,$2
	la	$25,fprintf
	jal	$31,$25
	la	$4,options
	la	$25,close_files
	jal	$31,$25
	li	$4,5			# 0x5
	la	$25,exit
	jal	$31,$25
$L21:
	lb	$3,24($fp)
	li	$2,-15			# 0xfffffffffffffff1
	xor	$2,$3,$2
	sltu	$2,$2,1
	sw	$2,28($fp)
$L17:
	lw	$2,28($fp)
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	decode_char
	.size	decode_char, .-decode_char
	.align	2
	.globl	encode
	.ent	encode
encode:
	.frame	$fp,56,$31		# vars= 40, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 0
	sw	$fp,52($sp)
	sw	$28,48($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	sw	$5,60($fp)
	lw	$3,60($fp)
	lw	$2,56($fp)
	lb	$2,0($2)
	sra	$2,$2,2
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$2,$2,1
	sw	$2,8($fp)
	lw	$2,56($fp)
	lb	$2,0($2)
	sw	$2,12($fp)
	lw	$2,12($fp)
	sw	$2,16($fp)
	lw	$3,16($fp)
	bgez	$3,$L23
	lw	$2,16($fp)
	addu	$2,$2,3
	sw	$2,16($fp)
$L23:
	lw	$3,16($fp)
	sra	$2,$3,2
	sll	$2,$2,2
	lw	$3,12($fp)
	subu	$2,$3,$2
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,4
	lw	$2,56($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	sra	$2,$2,4
	or	$2,$3,$2
	lw	$3,8($fp)
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$2,$2,2
	sw	$2,20($fp)
	lw	$2,56($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	sw	$2,24($fp)
	lw	$2,24($fp)
	sw	$2,28($fp)
	lw	$3,28($fp)
	bgez	$3,$L24
	lw	$2,28($fp)
	addu	$2,$2,15
	sw	$2,28($fp)
$L24:
	lw	$3,28($fp)
	sra	$2,$3,4
	sll	$2,$2,4
	lw	$3,24($fp)
	subu	$2,$3,$2
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,2
	lw	$2,56($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	sra	$2,$2,6
	or	$2,$3,$2
	lw	$3,20($fp)
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$2,$2,3
	sw	$2,32($fp)
	lw	$2,56($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	sw	$2,36($fp)
	lw	$2,36($fp)
	sw	$2,40($fp)
	lw	$3,40($fp)
	bgez	$3,$L25
	lw	$2,40($fp)
	addu	$2,$2,63
	sw	$2,40($fp)
$L25:
	lw	$3,40($fp)
	sra	$2,$3,6
	sll	$2,$2,6
	lw	$3,36($fp)
	subu	$2,$3,$2
	lw	$3,32($fp)
	sb	$2,0($3)
	lw	$3,60($fp)
	lw	$2,60($fp)
	lb	$2,0($2)
	lbu	$2,encode_table($2)
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$3,$2,1
	lw	$2,60($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	lbu	$2,encode_table($2)
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$3,$2,2
	lw	$2,60($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	lbu	$2,encode_table($2)
	sb	$2,0($3)
	lw	$2,60($fp)
	addu	$3,$2,3
	lw	$2,60($fp)
	addu	$2,$2,3
	lb	$2,0($2)
	lbu	$2,encode_table($2)
	sb	$2,0($3)
	move	$sp,$fp
	lw	$fp,52($sp)
	addu	$sp,$sp,56
	j	$31
	.end	encode
	.size	encode, .-encode
	.align	2
	.globl	decode
	.ent	decode
decode:
	.frame	$fp,88,$31		# vars= 48, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 16
	sw	$31,80($sp)
	sw	$fp,76($sp)
	sw	$28,72($sp)
	move	$fp,$sp
	sw	$4,88($fp)
	sw	$5,92($fp)
	lw	$2,88($fp)
	lb	$2,0($2)
	move	$4,$2
	la	$25,decode_char
	jal	$31,$25
	move	$3,$2
	lw	$2,88($fp)
	sb	$3,0($2)
	lw	$2,88($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	move	$4,$2
	la	$25,decode_char
	jal	$31,$25
	move	$3,$2
	lw	$2,88($fp)
	addu	$2,$2,1
	sb	$3,0($2)
	lw	$2,88($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	move	$4,$2
	la	$25,decode_char
	jal	$31,$25
	move	$3,$2
	lw	$2,88($fp)
	addu	$2,$2,2
	sb	$3,0($2)
	lw	$2,88($fp)
	addu	$2,$2,3
	lb	$2,0($2)
	move	$4,$2
	la	$25,decode_char
	jal	$31,$25
	move	$3,$2
	lw	$2,88($fp)
	addu	$2,$2,3
	sb	$3,0($2)
	lw	$2,92($fp)
	sw	$2,24($fp)
	lw	$2,88($fp)
	lb	$2,0($2)
	sw	$2,28($fp)
	lw	$3,28($fp)
	sw	$3,32($fp)
	lw	$4,32($fp)
	bgez	$4,$L27
	lw	$2,32($fp)
	addu	$2,$2,63
	sw	$2,32($fp)
$L27:
	lw	$3,32($fp)
	sra	$2,$3,6
	sll	$2,$2,6
	lw	$4,28($fp)
	subu	$2,$4,$2
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,2
	lw	$2,88($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	sra	$2,$2,4
	or	$2,$3,$2
	lw	$3,24($fp)
	sb	$2,0($3)
	lw	$2,92($fp)
	addu	$2,$2,1
	sw	$2,36($fp)
	lw	$2,88($fp)
	addu	$2,$2,1
	lb	$2,0($2)
	sw	$2,40($fp)
	lw	$4,40($fp)
	sw	$4,44($fp)
	lw	$2,44($fp)
	bgez	$2,$L28
	lw	$3,44($fp)
	addu	$3,$3,15
	sw	$3,44($fp)
$L28:
	lw	$4,44($fp)
	sra	$2,$4,4
	sll	$2,$2,4
	lw	$3,40($fp)
	subu	$2,$3,$2
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,4
	lw	$2,88($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	sra	$2,$2,2
	or	$2,$3,$2
	lw	$4,36($fp)
	sb	$2,0($4)
	lw	$2,92($fp)
	addu	$2,$2,2
	sw	$2,48($fp)
	lw	$2,88($fp)
	addu	$2,$2,2
	lb	$2,0($2)
	sw	$2,52($fp)
	lw	$2,52($fp)
	sw	$2,56($fp)
	lw	$3,56($fp)
	bgez	$3,$L29
	lw	$4,56($fp)
	addu	$4,$4,3
	sw	$4,56($fp)
$L29:
	lw	$3,56($fp)
	sra	$2,$3,2
	sll	$2,$2,2
	lw	$4,52($fp)
	subu	$2,$4,$2
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$2,$2,6
	sw	$2,60($fp)
	lw	$2,88($fp)
	addu	$2,$2,3
	lb	$2,0($2)
	sw	$2,64($fp)
	lw	$2,64($fp)
	sw	$2,68($fp)
	lw	$3,68($fp)
	bgez	$3,$L30
	lw	$4,68($fp)
	addu	$4,$4,63
	sw	$4,68($fp)
$L30:
	lw	$3,68($fp)
	sra	$2,$3,6
	sll	$2,$2,6
	lw	$4,64($fp)
	subu	$2,$4,$2
	lw	$4,60($fp)
	move	$3,$4
	or	$2,$3,$2
	lw	$3,48($fp)
	sb	$2,0($3)
	move	$sp,$fp
	lw	$31,80($sp)
	lw	$fp,76($sp)
	addu	$sp,$sp,88
	j	$31
	.end	decode
	.size	decode, .-decode
	.align	2
	.globl	read_bytes
	.ent	read_bytes
read_bytes:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
$L32:
	lw	$4,40($fp)
	lw	$5,44($fp)
	li	$6,1			# 0x1
	la	$25,read
	jal	$31,$25
	beq	$2,$0,$L33
	lw	$2,48($fp)
	addu	$2,$2,-1
	sw	$2,48($fp)
	bne	$2,$0,$L34
	b	$L33
$L34:
	lw	$2,44($fp)
	addu	$2,$2,1
	sw	$2,44($fp)
	b	$L32
$L33:
	lw	$2,48($fp)
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	read_bytes
	.size	read_bytes, .-read_bytes
	.align	2
	.globl	write_bytes
	.ent	write_bytes
write_bytes:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$4,40($fp)
	lw	$5,44($fp)
	lw	$6,48($fp)
	la	$25,write
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	write_bytes
	.size	write_bytes, .-write_bytes
	.align	2
	.globl	padding_count
	.ent	padding_count
padding_count:
	.frame	$fp,24,$31		# vars= 8, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,24
	.cprestore 0
	sw	$fp,20($sp)
	sw	$28,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	sw	$0,8($fp)
	sw	$0,12($fp)
$L38:
	lw	$2,12($fp)
	lw	$3,28($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L41
	b	$L39
$L41:
	lw	$3,24($fp)
	lw	$2,12($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	lb	$2,PADDING_SYMBOL
	xor	$2,$3,$2
	sltu	$2,$2,1
	lw	$3,8($fp)
	addu	$2,$2,$3
	sw	$2,8($fp)
	lw	$2,12($fp)
	addu	$2,$2,1
	sw	$2,12($fp)
	b	$L38
$L39:
	lw	$2,8($fp)
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$31
	.end	padding_count
	.size	padding_count, .-padding_count
	.rdata
	.align	2
$LC1:
	.ascii	"Decoding Error: Wrong encoded message length.\n\000"
	.text
	.align	2
	.globl	assert_decoding_buffer
	.ent	assert_decoding_buffer
assert_decoding_buffer:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	lw	$2,40($fp)
	lb	$3,0($2)
	lb	$2,PADDING_SYMBOL
	beq	$3,$2,$L44
	lw	$2,40($fp)
	addu	$2,$2,1
	lb	$3,0($2)
	lb	$2,PADDING_SYMBOL
	beq	$3,$2,$L44
	lw	$2,40($fp)
	addu	$2,$2,2
	lb	$3,0($2)
	lb	$2,PADDING_SYMBOL
	bne	$3,$2,$L42
	lw	$2,40($fp)
	addu	$2,$2,3
	lb	$3,0($2)
	lb	$2,PADDING_SYMBOL
	bne	$3,$2,$L44
	b	$L42
$L44:
	la	$4,__sF+176
	la	$5,$LC1
	la	$25,fprintf
	jal	$31,$25
	la	$4,options
	la	$25,close_files
	jal	$31,$25
	li	$4,6			# 0x6
	la	$25,exit
	jal	$31,$25
$L42:
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	assert_decoding_buffer
	.size	assert_decoding_buffer, .-assert_decoding_buffer
	.data
	.align	2
$LC2:
	.word	encode
	.word	decode
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,104,$31		# vars= 56, regs= 5/0, args= 16, extra= 8
	.mask	0xd0030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,104
	.cprestore 16
	sw	$31,96($sp)
	sw	$fp,92($sp)
	sw	$28,88($sp)
	sw	$17,84($sp)
	sw	$16,80($sp)
	move	$fp,$sp
	sw	$4,104($fp)
	sw	$5,108($fp)
	lw	$4,104($fp)
	lw	$5,108($fp)
	la	$6,options
	la	$25,parse_options
	jal	$31,$25
	lw	$2,$LC2
	sw	$2,24($fp)
	lw	$2,$LC2+4
	sw	$2,28($fp)
	sw	$0,32($fp)
	lbu	$2,options+8
	addu	$2,$2,3
	sw	$2,36($fp)
	lbu	$2,options+8
	bne	$2,$0,$L46
	li	$2,4			# 0x4
	sw	$2,72($fp)
	b	$L47
$L46:
	li	$2,3			# 0x3
	sw	$2,72($fp)
$L47:
	lw	$2,72($fp)
	sw	$2,40($fp)
$L48:
	lw	$2,32($fp)
	beq	$2,$0,$L50
	b	$L55
$L50:
	sw	$0,48($fp)
	sw	$0,56($fp)
	addu	$2,$fp,48
	lw	$4,options
	move	$5,$2
	lw	$6,36($fp)
	la	$25,read_bytes
	jal	$31,$25
	sw	$2,32($fp)
	lw	$3,32($fp)
	lw	$2,36($fp)
	bne	$3,$2,$L51
	sw	$0,32($fp)
	b	$L55
$L51:
	lw	$2,32($fp)
	beq	$2,$0,$L52
	lbu	$2,options+8
	beq	$2,$0,$L52
	la	$4,__sF+176
	la	$5,$LC1
	la	$25,fprintf
	jal	$31,$25
	li	$4,6			# 0x6
	la	$25,exit
	jal	$31,$25
$L52:
	lbu	$2,options+8
	beq	$2,$0,$L53
	addu	$2,$fp,48
	move	$4,$2
	la	$25,assert_decoding_buffer
	jal	$31,$25
$L53:
	lw	$3,40($fp)
	lw	$2,32($fp)
	subu	$17,$3,$2
	lbu	$16,options+8
	addu	$2,$fp,48
	move	$4,$2
	lw	$5,36($fp)
	la	$25,padding_count
	jal	$31,$25
	mult	$16,$2
	mflo	$2
	subu	$2,$17,$2
	sw	$2,64($fp)
	lb	$3,51($fp)
	lb	$2,PADDING_SYMBOL
	xor	$2,$3,$2
	sltu	$2,$2,1
	sb	$2,68($fp)
	lbu	$2,options+8
	sll	$3,$2,2
	addu	$2,$fp,24
	addu	$2,$3,$2
	addu	$3,$fp,48
	addu	$5,$fp,56
	lw	$2,0($2)
	move	$4,$3
	move	$25,$2
	jal	$31,$25
	addu	$2,$fp,56
	lw	$4,options+4
	move	$5,$2
	lw	$6,64($fp)
	la	$25,write_bytes
	jal	$31,$25
	lbu	$2,68($fp)
	beq	$2,$0,$L48
$L55:
	lw	$2,32($fp)
	addu	$2,$2,-1
	move	$3,$2
	sw	$3,32($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L57
	b	$L56
$L57:
	lw	$4,options+4
	la	$5,PADDING_SYMBOL
	li	$6,1			# 0x1
	la	$25,write
	jal	$31,$25
	b	$L55
$L56:
	la	$4,options
	la	$25,close_files
	jal	$31,$25
	move	$2,$0
	move	$sp,$fp
	lw	$31,96($sp)
	lw	$fp,92($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	addu	$sp,$sp,104
	j	$31
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
