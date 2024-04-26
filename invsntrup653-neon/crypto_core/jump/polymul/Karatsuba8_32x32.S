.align 6
.global __asm_8x32x32
.global ___asm_8x32x32
__asm_8x32x32:
___asm_8x32x32:
   //Initialization
   mov      w5,  #0
   DUP      v0.8H,  w5
   str q0, [x3, #240+0*256]
   str q0, [x3, #240+1*256]
   str q0, [x3, #240+2*256]
   str q0, [x3, #240+3*256]
   str q0, [x3, #240+4*256]
   str q0, [x3, #240+5*256]
   str q0, [x3, #240+6*256]
   str q0, [x3, #240+7*256]
   str q0, [x3, #240+8*256]

   //a0:v16-v23
   ldr q8, [x1, #0*64]
   ldr q9, [x1, #1*64]
   ldr q10, [x1, #2*64]
   ldr q11, [x1, #3*64]
   ldr q12, [x1, #4*64]
   ldr q13, [x1, #5*64]
   ldr q14, [x1, #6*64]
   ldr q15, [x1, #7*64]

   trn1 v16.2d, v8.2d, v12.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v23.8h, v11.8h, v15.8h

   //b0:v24-v31
   ldr q8, [x2, #0*64]
   ldr q9, [x2, #1*64]
   ldr q10, [x2, #2*64]
   ldr q11, [x2, #3*64]
   ldr q12, [x2, #4*64]
   ldr q13, [x2, #5*64]
   ldr q14, [x2, #6*64]
   ldr q15, [x2, #7*64]

   trn1 v24.2d, v8.2d, v12.2d
   trn2 v25.2d, v8.2d, v12.2d
   trn1 v26.2d, v9.2d, v13.2d
   trn2 v27.2d, v9.2d, v13.2d
   trn1 v28.2d, v10.2d, v14.2d
   trn2 v29.2d, v10.2d, v14.2d
   trn1 v30.2d, v11.2d, v15.2d
   trn2 v31.2d, v11.2d, v15.2d

   trn1 v8.4s, v24.4s, v28.4s
   trn2 v9.4s, v24.4s, v28.4s
   trn1 v10.4s, v25.4s, v29.4s
   trn2 v11.4s, v25.4s, v29.4s
   trn1 v12.4s, v26.4s, v30.4s
   trn2 v13.4s, v26.4s, v30.4s
   trn1 v14.4s, v27.4s, v31.4s
   trn2 v15.4s, v27.4s, v31.4s

   trn1 v24.8h, v8.8h, v12.8h
   trn2 v25.8h, v8.8h, v12.8h
   trn1 v26.8h, v9.8h, v13.8h
   trn2 v27.8h, v9.8h, v13.8h
   trn1 v28.8h, v10.8h, v14.8h
   trn2 v29.8h, v10.8h, v14.8h
   trn1 v30.8h, v11.8h, v15.8h
   trn2 v31.8h, v11.8h, v15.8h

   //a0b0
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #0*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #14*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   SMULL2   v15.4S,  v16.8h,  v25.8h
   SMULL    v11.4S,  v22.4h,  v31.4h
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v30.4h
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #1*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #13*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   SMULL2   v15.4S,  v16.8h,  v26.8h
   SMULL    v11.4S,  v21.4h,  v31.4h
   SMULL2   v12.4S,  v21.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #2*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #12*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #3*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #11*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #4*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #10*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #5*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #9*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #6*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #8*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #7*16]


   //a1:v0-v7
   ldr q8, [x1, #0*64+16]
   ldr q9, [x1, #1*64+16]
   ldr q10, [x1, #2*64+16]
   ldr q11, [x1, #3*64+16]
   ldr q12, [x1, #4*64+16]
   ldr q13, [x1, #5*64+16]
   ldr q14, [x1, #6*64+16]
   ldr q15, [x1, #7*64+16]

   trn1 v0.2d, v8.2d, v12.2d
   trn1 v2.2d, v9.2d, v13.2d
   trn1 v4.2d, v10.2d, v14.2d
   trn1 v6.2d, v11.2d, v15.2d
   trn2 v1.2d, v8.2d, v12.2d
   trn2 v3.2d, v9.2d, v13.2d
   trn2 v5.2d, v10.2d, v14.2d
   trn2 v7.2d, v11.2d, v15.2d

   trn1 v8.4s, v0.4s, v4.4s
   trn1 v10.4s, v1.4s, v5.4s
   trn1 v12.4s, v2.4s, v6.4s
   trn1 v14.4s, v3.4s, v7.4s
   trn2 v9.4s, v0.4s, v4.4s
   trn2 v11.4s, v1.4s, v5.4s
   trn2 v13.4s, v2.4s, v6.4s
   trn2 v15.4s, v3.4s, v7.4s

   trn1 v0.8h, v8.8h, v12.8h
   trn1 v2.8h, v9.8h, v13.8h
   trn1 v4.8h, v10.8h, v14.8h
   trn1 v6.8h, v11.8h, v15.8h
   trn2 v1.8h, v8.8h, v12.8h
   trn2 v3.8h, v9.8h, v13.8h
   trn2 v5.8h, v10.8h, v14.8h
   trn2 v7.8h, v11.8h, v15.8h

   //store a0
   str q16, [x4, #0*16]
   str q17, [x4, #1*16]
   str q18, [x4, #2*16]
   str q19, [x4, #3*16]
   str q20, [x4, #4*16]
   str q21, [x4, #5*16]
   str q22, [x4, #6*16]
   str q23, [x4, #7*16]

   //store a4 = a0 + a1
   ADD v16.8h, v16.8h, v0.8h
   ADD v17.8h, v17.8h, v1.8h
   ADD v18.8h, v18.8h, v2.8h
   ADD v19.8h, v19.8h, v3.8h
   ADD v20.8h, v20.8h, v4.8h
   ADD v21.8h, v21.8h, v5.8h
   ADD v22.8h, v22.8h, v6.8h
   ADD v23.8h, v23.8h, v7.8h
   str q16, [x4, #8*16]
   str q17, [x4, #9*16]
   str q18, [x4, #10*16]
   str q19, [x4, #11*16]
   str q20, [x4, #12*16]
   str q21, [x4, #13*16]
   str q22, [x4, #14*16]
   str q23, [x4, #15*16]

   //b1:v16-v23
   ldr q8, [x2, #0*64+16]
   ldr q9, [x2, #1*64+16]
   ldr q10, [x2, #2*64+16]
   ldr q11, [x2, #3*64+16]
   ldr q12, [x2, #4*64+16]
   ldr q13, [x2, #5*64+16]
   ldr q14, [x2, #6*64+16]
   ldr q15, [x2, #7*64+16]

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn2 v23.8h, v11.8h, v15.8h

   //store b0
   str q24, [x4, #32*16]
   str q25, [x4, #33*16]
   str q26, [x4, #34*16]
   str q27, [x4, #35*16]
   str q28, [x4, #36*16]
   str q29, [x4, #37*16]
   str q30, [x4, #38*16]
   str q31, [x4, #39*16]

   //store b4 = b0 + b1
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h
   str q24, [x4, #40*16]
   str q25, [x4, #41*16]
   str q26, [x4, #42*16]
   str q27, [x4, #43*16]
   str q28, [x4, #44*16]
   str q29, [x4, #45*16]
   str q30, [x4, #46*16]
   str q31, [x4, #47*16]

   //a1b1 [v0-v7][v16-v23]
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]

   SMULL    v14.4S,  v16.4h,  v0.4h
   SMULL2   v15.4S,  v16.8h,  v0.8h
   SMULL    v11.4S,  v23.4h,  v7.4h
   SMULL2   v12.4S,  v23.8h,  v7.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #16*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #30*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v1.4h
   SMULL2   v15.4S,  v16.8h,  v1.8h
   SMULL    v11.4S,  v22.4h,  v7.4h
   SMULL2   v12.4S,  v22.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v0.4h
   SMLAL2   v15.4S,  v17.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v6.4h
   SMLAL2   v12.4S,  v23.8h,  v6.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #17*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #29*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v2.4h
   SMULL2   v15.4S,  v16.8h,  v2.8h
   SMULL    v11.4S,  v21.4h,  v7.4h
   SMULL2   v12.4S,  v21.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v1.4h
   SMLAL2   v15.4S,  v17.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v6.4h
   SMLAL2   v12.4S,  v22.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v0.4h
   SMLAL2   v15.4S,  v18.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v5.4h
   SMLAL2   v12.4S,  v23.8h,  v5.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #18*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #28*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v3.4h
   SMULL2   v15.4S,  v16.8h,  v3.8h
   SMULL    v11.4S,  v20.4h,  v7.4h
   SMULL2   v12.4S,  v20.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v2.4h
   SMLAL2   v15.4S,  v17.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v6.4h
   SMLAL2   v12.4S,  v21.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v1.4h
   SMLAL2   v15.4S,  v18.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v5.4h
   SMLAL2   v12.4S,  v22.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v0.4h
   SMLAL2   v15.4S,  v19.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v4.4h
   SMLAL2   v12.4S,  v23.8h,  v4.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #19*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #27*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v4.4h
   SMULL2   v15.4S,  v16.8h,  v4.8h
   SMULL    v11.4S,  v19.4h,  v7.4h
   SMULL2   v12.4S,  v19.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v3.4h
   SMLAL2   v15.4S,  v17.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v6.4h
   SMLAL2   v12.4S,  v20.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v2.4h
   SMLAL2   v15.4S,  v18.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v5.4h
   SMLAL2   v12.4S,  v21.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v1.4h
   SMLAL2   v15.4S,  v19.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v4.4h
   SMLAL2   v12.4S,  v22.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v0.4h
   SMLAL2   v15.4S,  v20.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v3.4h
   SMLAL2   v12.4S,  v23.8h,  v3.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #20*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #26*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v5.4h
   SMULL2   v15.4S,  v16.8h,  v5.8h
   SMULL    v11.4S,  v18.4h,  v7.4h
   SMULL2   v12.4S,  v18.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v4.4h
   SMLAL2   v15.4S,  v17.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v6.4h
   SMLAL2   v12.4S,  v19.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v3.4h
   SMLAL2   v15.4S,  v18.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v5.4h
   SMLAL2   v12.4S,  v20.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v2.4h
   SMLAL2   v15.4S,  v19.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v4.4h
   SMLAL2   v12.4S,  v21.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v1.4h
   SMLAL2   v15.4S,  v20.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v3.4h
   SMLAL2   v12.4S,  v22.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v0.4h
   SMLAL2   v15.4S,  v21.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v2.4h
   SMLAL2   v12.4S,  v23.8h,  v2.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #21*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #25*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v6.4h
   SMULL2   v15.4S,  v16.8h,  v6.8h
   SMULL    v11.4S,  v17.4h,  v7.4h
   SMULL2   v12.4S,  v17.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v5.4h
   SMLAL2   v15.4S,  v17.8h,  v5.8h
   SMLAL    v11.4S,  v18.4h,  v6.4h
   SMLAL2   v12.4S,  v18.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v4.4h
   SMLAL2   v15.4S,  v18.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v5.4h
   SMLAL2   v12.4S,  v19.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v3.4h
   SMLAL2   v15.4S,  v19.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v4.4h
   SMLAL2   v12.4S,  v20.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v2.4h
   SMLAL2   v15.4S,  v20.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v3.4h
   SMLAL2   v12.4S,  v21.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v1.4h
   SMLAL2   v15.4S,  v21.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v2.4h
   SMLAL2   v12.4S,  v22.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v0.4h
   SMLAL2   v15.4S,  v22.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v1.4h
   SMLAL2   v12.4S,  v23.8h,  v1.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #22*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #24*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v7.4h
   SMULL2   v15.4S,  v16.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v6.4h
   SMLAL2   v15.4S,  v17.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v5.4h
   SMLAL2   v15.4S,  v18.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v4.4h
   SMLAL2   v15.4S,  v19.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v3.4h
   SMLAL2   v15.4S,  v20.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v2.4h
   SMLAL2   v15.4S,  v21.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v1.4h
   SMLAL2   v15.4S,  v22.8h,  v1.8h
   SMLAL    v14.4S,  v23.4h,  v0.4h
   SMLAL2   v15.4S,  v23.8h,  v0.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #23*16]

   //b3:v24-v31
   ldr q8, [x2, #0*64+48]
   ldr q9, [x2, #1*64+48]
   ldr q10, [x2, #2*64+48]
   ldr q11, [x2, #3*64+48]
   ldr q12, [x2, #4*64+48]
   ldr q13, [x2, #5*64+48]
   ldr q14, [x2, #6*64+48]
   ldr q15, [x2, #7*64+48]

   trn1 v24.2d, v8.2d, v12.2d
   trn1 v26.2d, v9.2d, v13.2d
   trn1 v28.2d, v10.2d, v14.2d
   trn1 v30.2d, v11.2d, v15.2d
   trn2 v25.2d, v8.2d, v12.2d
   trn2 v27.2d, v9.2d, v13.2d
   trn2 v29.2d, v10.2d, v14.2d
   trn2 v31.2d, v11.2d, v15.2d

   trn1 v8.4s, v24.4s, v28.4s
   trn1 v10.4s, v25.4s, v29.4s
   trn1 v12.4s, v26.4s, v30.4s
   trn1 v14.4s, v27.4s, v31.4s
   trn2 v9.4s, v24.4s, v28.4s
   trn2 v11.4s, v25.4s, v29.4s
   trn2 v13.4s, v26.4s, v30.4s
   trn2 v15.4s, v27.4s, v31.4s

   trn1 v24.8h, v8.8h, v12.8h
   trn1 v26.8h, v9.8h, v13.8h
   trn1 v28.8h, v10.8h, v14.8h
   trn1 v30.8h, v11.8h, v15.8h
   trn2 v25.8h, v8.8h, v12.8h
   trn2 v27.8h, v9.8h, v13.8h
   trn2 v29.8h, v10.8h, v14.8h
   trn2 v31.8h, v11.8h, v15.8h

   //store b7 = b3 + b1
   ADD v16.8h, v24.8h, v16.8h
   ADD v17.8h, v25.8h, v17.8h
   ADD v18.8h, v26.8h, v18.8h
   ADD v19.8h, v27.8h, v19.8h
   ADD v20.8h, v28.8h, v20.8h
   ADD v21.8h, v29.8h, v21.8h
   ADD v22.8h, v30.8h, v22.8h
   ADD v23.8h, v31.8h, v23.8h
   str q16, [x4, #56*16]
   str q17, [x4, #57*16]
   str q18, [x4, #58*16]
   str q19, [x4, #59*16]
   str q20, [x4, #60*16]
   str q21, [x4, #61*16]
   str q22, [x4, #62*16]
   str q23, [x4, #63*16]

   //a3:v16-v23
   ldr q8, [x1, #0*64+48]
   ldr q9, [x1, #1*64+48]
   ldr q10, [x1, #2*64+48]
   ldr q11, [x1, #3*64+48]
   ldr q12, [x1, #4*64+48]
   ldr q13, [x1, #5*64+48]
   ldr q14, [x1, #6*64+48]
   ldr q15, [x1, #7*64+48]

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn2 v23.8h, v11.8h, v15.8h

   //store a7 = a3 + a1
   ADD v0.8h, v16.8h, v0.8h
   ADD v1.8h, v17.8h, v1.8h
   ADD v2.8h, v18.8h, v2.8h
   ADD v3.8h, v19.8h, v3.8h
   ADD v4.8h, v20.8h, v4.8h
   ADD v5.8h, v21.8h, v5.8h
   ADD v6.8h, v22.8h, v6.8h
   ADD v7.8h, v23.8h, v7.8h
   str q0, [x4, #24*16]
   str q1, [x4, #25*16]
   str q2, [x4, #26*16]
   str q3, [x4, #27*16]
   str q4, [x4, #28*16]
   str q5, [x4, #29*16]
   str q6, [x4, #30*16]
   str q7, [x4, #31*16]

   //a3b3
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #48*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #62*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   SMULL2   v15.4S,  v16.8h,  v25.8h
   SMULL    v11.4S,  v22.4h,  v31.4h
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v30.4h
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #49*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #61*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   SMULL2   v15.4S,  v16.8h,  v26.8h
   SMULL    v11.4S,  v21.4h,  v31.4h
   SMULL2   v12.4S,  v21.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #50*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #60*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #51*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #59*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #52*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #58*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #53*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #57*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #54*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #56*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #55*16]


   //a2:v0-v7
   ldr q8, [x1, #0*64+32]
   ldr q9, [x1, #1*64+32]
   ldr q10, [x1, #2*64+32]
   ldr q11, [x1, #3*64+32]
   ldr q12, [x1, #4*64+32]
   ldr q13, [x1, #5*64+32]
   ldr q14, [x1, #6*64+32]
   ldr q15, [x1, #7*64+32]

   trn1 v0.2d, v8.2d, v12.2d
   trn1 v2.2d, v9.2d, v13.2d
   trn1 v4.2d, v10.2d, v14.2d
   trn1 v6.2d, v11.2d, v15.2d
   trn2 v1.2d, v8.2d, v12.2d
   trn2 v3.2d, v9.2d, v13.2d
   trn2 v5.2d, v10.2d, v14.2d
   trn2 v7.2d, v11.2d, v15.2d

   trn1 v8.4s, v0.4s, v4.4s
   trn1 v10.4s, v1.4s, v5.4s
   trn1 v12.4s, v2.4s, v6.4s
   trn1 v14.4s, v3.4s, v7.4s
   trn2 v9.4s, v0.4s, v4.4s
   trn2 v11.4s, v1.4s, v5.4s
   trn2 v13.4s, v2.4s, v6.4s
   trn2 v15.4s, v3.4s, v7.4s

   trn1 v0.8h, v8.8h, v12.8h
   trn1 v2.8h, v9.8h, v13.8h
   trn1 v4.8h, v10.8h, v14.8h
   trn1 v6.8h, v11.8h, v15.8h
   trn2 v1.8h, v8.8h, v12.8h
   trn2 v3.8h, v9.8h, v13.8h
   trn2 v5.8h, v10.8h, v14.8h
   trn2 v7.8h, v11.8h, v15.8h

   //store a5 = a3 + a2
   ADD v16.8h, v16.8h, v0.8h
   ADD v17.8h, v17.8h, v1.8h
   ADD v18.8h, v18.8h, v2.8h
   ADD v19.8h, v19.8h, v3.8h
   ADD v20.8h, v20.8h, v4.8h
   ADD v21.8h, v21.8h, v5.8h
   ADD v22.8h, v22.8h, v6.8h
   ADD v23.8h, v23.8h, v7.8h
   str q16, [x4, #16*16]
   str q17, [x4, #17*16]
   str q18, [x4, #18*16]
   str q19, [x4, #19*16]
   str q20, [x4, #20*16]
   str q21, [x4, #21*16]
   str q22, [x4, #22*16]
   str q23, [x4, #23*16]

   //b2:v16-v23
   ldr q8, [x2, #0*64+32]
   ldr q9, [x2, #1*64+32]
   ldr q10, [x2, #2*64+32]
   ldr q11, [x2, #3*64+32]
   ldr q12, [x2, #4*64+32]
   ldr q13, [x2, #5*64+32]
   ldr q14, [x2, #6*64+32]
   ldr q15, [x2, #7*64+32]

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn2 v23.8h, v11.8h, v15.8h

   //store b5 = b3 + b2
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h
   str q24, [x4, #48*16]
   str q25, [x4, #49*16]
   str q26, [x4, #50*16]
   str q27, [x4, #51*16]
   str q28, [x4, #52*16]
   str q29, [x4, #53*16]
   str q30, [x4, #54*16]
   str q31, [x4, #55*16]

   //a2b2
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v0.4h
   SMULL2   v15.4S,  v16.8h,  v0.8h
   SMULL    v11.4S,  v23.4h,  v7.4h
   SMULL2   v12.4S,  v23.8h,  v7.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #32*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #46*16]


   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v1.4h
   SMULL2   v15.4S,  v16.8h,  v1.8h
   SMULL    v11.4S,  v22.4h,  v7.4h
   SMULL2   v12.4S,  v22.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v0.4h
   SMLAL2   v15.4S,  v17.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v6.4h
   SMLAL2   v12.4S,  v23.8h,  v6.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #33*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #45*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v2.4h
   SMULL2   v15.4S,  v16.8h,  v2.8h
   SMULL    v11.4S,  v21.4h,  v7.4h
   SMULL2   v12.4S,  v21.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v1.4h
   SMLAL2   v15.4S,  v17.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v6.4h
   SMLAL2   v12.4S,  v22.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v0.4h
   SMLAL2   v15.4S,  v18.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v5.4h
   SMLAL2   v12.4S,  v23.8h,  v5.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #34*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #44*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v3.4h
   SMULL2   v15.4S,  v16.8h,  v3.8h
   SMULL    v11.4S,  v20.4h,  v7.4h
   SMULL2   v12.4S,  v20.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v2.4h
   SMLAL2   v15.4S,  v17.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v6.4h
   SMLAL2   v12.4S,  v21.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v1.4h
   SMLAL2   v15.4S,  v18.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v5.4h
   SMLAL2   v12.4S,  v22.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v0.4h
   SMLAL2   v15.4S,  v19.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v4.4h
   SMLAL2   v12.4S,  v23.8h,  v4.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #35*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #43*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v4.4h
   SMULL2   v15.4S,  v16.8h,  v4.8h
   SMULL    v11.4S,  v19.4h,  v7.4h
   SMULL2   v12.4S,  v19.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v3.4h
   SMLAL2   v15.4S,  v17.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v6.4h
   SMLAL2   v12.4S,  v20.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v2.4h
   SMLAL2   v15.4S,  v18.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v5.4h
   SMLAL2   v12.4S,  v21.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v1.4h
   SMLAL2   v15.4S,  v19.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v4.4h
   SMLAL2   v12.4S,  v22.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v0.4h
   SMLAL2   v15.4S,  v20.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v3.4h
   SMLAL2   v12.4S,  v23.8h,  v3.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #36*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #42*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v5.4h
   SMULL2   v15.4S,  v16.8h,  v5.8h
   SMULL    v11.4S,  v18.4h,  v7.4h
   SMULL2   v12.4S,  v18.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v4.4h
   SMLAL2   v15.4S,  v17.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v6.4h
   SMLAL2   v12.4S,  v19.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v3.4h
   SMLAL2   v15.4S,  v18.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v5.4h
   SMLAL2   v12.4S,  v20.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v2.4h
   SMLAL2   v15.4S,  v19.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v4.4h
   SMLAL2   v12.4S,  v21.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v1.4h
   SMLAL2   v15.4S,  v20.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v3.4h
   SMLAL2   v12.4S,  v22.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v0.4h
   SMLAL2   v15.4S,  v21.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v2.4h
   SMLAL2   v12.4S,  v23.8h,  v2.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #37*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #41*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v6.4h
   SMULL2   v15.4S,  v16.8h,  v6.8h
   SMULL    v11.4S,  v17.4h,  v7.4h
   SMULL2   v12.4S,  v17.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v5.4h
   SMLAL2   v15.4S,  v17.8h,  v5.8h
   SMLAL    v11.4S,  v18.4h,  v6.4h
   SMLAL2   v12.4S,  v18.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v4.4h
   SMLAL2   v15.4S,  v18.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v5.4h
   SMLAL2   v12.4S,  v19.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v3.4h
   SMLAL2   v15.4S,  v19.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v4.4h
   SMLAL2   v12.4S,  v20.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v2.4h
   SMLAL2   v15.4S,  v20.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v3.4h
   SMLAL2   v12.4S,  v21.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v1.4h
   SMLAL2   v15.4S,  v21.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v2.4h
   SMLAL2   v12.4S,  v22.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v0.4h
   SMLAL2   v15.4S,  v22.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v1.4h
   SMLAL2   v12.4S,  v23.8h,  v1.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #38*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #40*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v7.4h
   SMULL2   v15.4S,  v16.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v6.4h
   SMLAL2   v15.4S,  v17.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v5.4h
   SMLAL2   v15.4S,  v18.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v4.4h
   SMLAL2   v15.4S,  v19.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v3.4h
   SMLAL2   v15.4S,  v20.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v2.4h
   SMLAL2   v15.4S,  v21.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v1.4h
   SMLAL2   v15.4S,  v22.8h,  v1.8h
   SMLAL    v14.4S,  v23.4h,  v0.4h
   SMLAL2   v15.4S,  v23.8h,  v0.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #39*16]

   //load a0
   ldr q24, [x4, #0*16]
   ldr q25, [x4, #1*16]
   ldr q26, [x4, #2*16]
   ldr q27, [x4, #3*16]
   ldr q28, [x4, #4*16]
   ldr q29, [x4, #5*16]
   ldr q30, [x4, #6*16]
   ldr q31, [x4, #7*16]

   //a6 = a0 + a2
   ADD v24.8h, v24.8h, v0.8h
   ADD v25.8h, v25.8h, v1.8h
   ADD v26.8h, v26.8h, v2.8h
   ADD v27.8h, v27.8h, v3.8h
   ADD v28.8h, v28.8h, v4.8h
   ADD v29.8h, v29.8h, v5.8h
   ADD v30.8h, v30.8h, v6.8h
   ADD v31.8h, v31.8h, v7.8h

   //load b0
   ldr q0, [x4, #32*16]
   ldr q1, [x4, #33*16]
   ldr q2, [x4, #34*16]
   ldr q3, [x4, #35*16]
   ldr q4, [x4, #36*16]
   ldr q5, [x4, #37*16]
   ldr q6, [x4, #38*16]
   ldr q7, [x4, #39*16]

   //b6 = b2 + b0
   ADD v16.8h, v16.8h, v0.8h
   ADD v17.8h, v17.8h, v1.8h
   ADD v18.8h, v18.8h, v2.8h
   ADD v19.8h, v19.8h, v3.8h
   ADD v20.8h, v20.8h, v4.8h
   ADD v21.8h, v21.8h, v5.8h
   ADD v22.8h, v22.8h, v6.8h
   ADD v23.8h, v23.8h, v7.8h
   
   //a6b6
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #96*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #110*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   SMULL2   v15.4S,  v16.8h,  v25.8h
   SMULL    v11.4S,  v22.4h,  v31.4h
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v30.4h
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #97*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #109*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   SMULL2   v15.4S,  v16.8h,  v26.8h
   SMULL    v11.4S,  v21.4h,  v31.4h
   SMULL2   v12.4S,  v21.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #98*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #108*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #99*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #107*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #100*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #106*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #101*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #105*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #102*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #104*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #103*16]


   //load a7 = a1 + a3
   ldr q0, [x4, #24*16]
   ldr q1, [x4, #25*16]
   ldr q2, [x4, #26*16]
   ldr q3, [x4, #27*16]
   ldr q4, [x4, #28*16]
   ldr q5, [x4, #29*16]
   ldr q6, [x4, #30*16]
   ldr q7, [x4, #31*16]

   //a8 = (a0+a2) + (a1+a3)
   ADD v24.8h, v24.8h, v0.8h
   ADD v25.8h, v25.8h, v1.8h
   ADD v26.8h, v26.8h, v2.8h
   ADD v27.8h, v27.8h, v3.8h
   ADD v28.8h, v28.8h, v4.8h
   ADD v29.8h, v29.8h, v5.8h
   ADD v30.8h, v30.8h, v6.8h
   ADD v31.8h, v31.8h, v7.8h
   
   //load b7 = b1 + b3
   ldr q0, [x4, #56*16]
   ldr q1, [x4, #57*16]
   ldr q2, [x4, #58*16]
   ldr q3, [x4, #59*16]
   ldr q4, [x4, #60*16]
   ldr q5, [x4, #61*16]
   ldr q6, [x4, #62*16]
   ldr q7, [x4, #63*16]

   //b8 = (b0+b2) + (b1+b3)
   ADD v16.8h, v16.8h, v0.8h
   ADD v17.8h, v17.8h, v1.8h
   ADD v18.8h, v18.8h, v2.8h
   ADD v19.8h, v19.8h, v3.8h
   ADD v20.8h, v20.8h, v4.8h
   ADD v21.8h, v21.8h, v5.8h
   ADD v22.8h, v22.8h, v6.8h
   ADD v23.8h, v23.8h, v7.8h

   //a8b8
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #128*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #142*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   SMULL2   v15.4S,  v16.8h,  v25.8h
   SMULL    v11.4S,  v22.4h,  v31.4h
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v30.4h
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #129*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #141*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   SMULL2   v15.4S,  v16.8h,  v26.8h
   SMULL    v11.4S,  v21.4h,  v31.4h
   SMULL2   v12.4S,  v21.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #130*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #140*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #131*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #139*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #132*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #138*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #133*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #137*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #134*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #136*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #135*16]

   //load a7 = a1 + a3
   ldr q16, [x4, #24*16]
   ldr q17, [x4, #25*16]
   ldr q18, [x4, #26*16]
   ldr q19, [x4, #27*16]
   ldr q20, [x4, #28*16]
   ldr q21, [x4, #29*16]
   ldr q22, [x4, #30*16]
   ldr q23, [x4, #31*16]
   
   //a7b7
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v0.4h
   SMULL2   v15.4S,  v16.8h,  v0.8h
   SMULL    v11.4S,  v23.4h,  v7.4h
   SMULL2   v12.4S,  v23.8h,  v7.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #112*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #126*16]


   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v1.4h
   SMULL2   v15.4S,  v16.8h,  v1.8h
   SMULL    v11.4S,  v22.4h,  v7.4h
   SMULL2   v12.4S,  v22.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v0.4h
   SMLAL2   v15.4S,  v17.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v6.4h
   SMLAL2   v12.4S,  v23.8h,  v6.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #113*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #125*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v2.4h
   SMULL2   v15.4S,  v16.8h,  v2.8h
   SMULL    v11.4S,  v21.4h,  v7.4h
   SMULL2   v12.4S,  v21.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v1.4h
   SMLAL2   v15.4S,  v17.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v6.4h
   SMLAL2   v12.4S,  v22.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v0.4h
   SMLAL2   v15.4S,  v18.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v5.4h
   SMLAL2   v12.4S,  v23.8h,  v5.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #114*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #124*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v3.4h
   SMULL2   v15.4S,  v16.8h,  v3.8h
   SMULL    v11.4S,  v20.4h,  v7.4h
   SMULL2   v12.4S,  v20.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v2.4h
   SMLAL2   v15.4S,  v17.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v6.4h
   SMLAL2   v12.4S,  v21.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v1.4h
   SMLAL2   v15.4S,  v18.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v5.4h
   SMLAL2   v12.4S,  v22.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v0.4h
   SMLAL2   v15.4S,  v19.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v4.4h
   SMLAL2   v12.4S,  v23.8h,  v4.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #115*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #123*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v4.4h
   SMULL2   v15.4S,  v16.8h,  v4.8h
   SMULL    v11.4S,  v19.4h,  v7.4h
   SMULL2   v12.4S,  v19.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v3.4h
   SMLAL2   v15.4S,  v17.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v6.4h
   SMLAL2   v12.4S,  v20.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v2.4h
   SMLAL2   v15.4S,  v18.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v5.4h
   SMLAL2   v12.4S,  v21.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v1.4h
   SMLAL2   v15.4S,  v19.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v4.4h
   SMLAL2   v12.4S,  v22.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v0.4h
   SMLAL2   v15.4S,  v20.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v3.4h
   SMLAL2   v12.4S,  v23.8h,  v3.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #116*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #122*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v5.4h
   SMULL2   v15.4S,  v16.8h,  v5.8h
   SMULL    v11.4S,  v18.4h,  v7.4h
   SMULL2   v12.4S,  v18.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v4.4h
   SMLAL2   v15.4S,  v17.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v6.4h
   SMLAL2   v12.4S,  v19.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v3.4h
   SMLAL2   v15.4S,  v18.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v5.4h
   SMLAL2   v12.4S,  v20.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v2.4h
   SMLAL2   v15.4S,  v19.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v4.4h
   SMLAL2   v12.4S,  v21.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v1.4h
   SMLAL2   v15.4S,  v20.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v3.4h
   SMLAL2   v12.4S,  v22.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v0.4h
   SMLAL2   v15.4S,  v21.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v2.4h
   SMLAL2   v12.4S,  v23.8h,  v2.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #117*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #121*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v6.4h
   SMULL2   v15.4S,  v16.8h,  v6.8h
   SMULL    v11.4S,  v17.4h,  v7.4h
   SMULL2   v12.4S,  v17.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v5.4h
   SMLAL2   v15.4S,  v17.8h,  v5.8h
   SMLAL    v11.4S,  v18.4h,  v6.4h
   SMLAL2   v12.4S,  v18.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v4.4h
   SMLAL2   v15.4S,  v18.8h,  v4.8h
   SMLAL    v11.4S,  v19.4h,  v5.4h
   SMLAL2   v12.4S,  v19.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v3.4h
   SMLAL2   v15.4S,  v19.8h,  v3.8h
   SMLAL    v11.4S,  v20.4h,  v4.4h
   SMLAL2   v12.4S,  v20.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v2.4h
   SMLAL2   v15.4S,  v20.8h,  v2.8h
   SMLAL    v11.4S,  v21.4h,  v3.4h
   SMLAL2   v12.4S,  v21.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v1.4h
   SMLAL2   v15.4S,  v21.8h,  v1.8h
   SMLAL    v11.4S,  v22.4h,  v2.4h
   SMLAL2   v12.4S,  v22.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v0.4h
   SMLAL2   v15.4S,  v22.8h,  v0.8h
   SMLAL    v11.4S,  v23.4h,  v1.4h
   SMLAL2   v12.4S,  v23.8h,  v1.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #118*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #120*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v7.4h
   SMULL2   v15.4S,  v16.8h,  v7.8h
   SMLAL    v14.4S,  v17.4h,  v6.4h
   SMLAL2   v15.4S,  v17.8h,  v6.8h
   SMLAL    v14.4S,  v18.4h,  v5.4h
   SMLAL2   v15.4S,  v18.8h,  v5.8h
   SMLAL    v14.4S,  v19.4h,  v4.4h
   SMLAL2   v15.4S,  v19.8h,  v4.8h
   SMLAL    v14.4S,  v20.4h,  v3.4h
   SMLAL2   v15.4S,  v20.8h,  v3.8h
   SMLAL    v14.4S,  v21.4h,  v2.4h
   SMLAL2   v15.4S,  v21.8h,  v2.8h
   SMLAL    v14.4S,  v22.4h,  v1.4h
   SMLAL2   v15.4S,  v22.8h,  v1.8h
   SMLAL    v14.4S,  v23.4h,  v0.4h
   SMLAL2   v15.4S,  v23.8h,  v0.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #119*16]


   //load a4 = a0 + a1; load b4 = b0 + b1
   ldr q16, [x4, #8*16]
   ldr q24, [x4, #40*16]

   //a4b4
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h
   ldr q23, [x4, #15*16]
   SMULL2   v15.4S,  v16.8h,  v24.8h
   ldr q31, [x4, #47*16]
   SMULL    v11.4S,  v23.4h,  v31.4h
   ldr q25, [x4, #41*16]
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #64*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #78*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   ldr q22, [x4, #14*16]
   SMULL2   v15.4S,  v16.8h,  v25.8h
   ldr q17, [x4, #9*16]
   SMULL    v11.4S,  v22.4h,  v31.4h
   ldr q30, [x4, #46*16]
   SMULL2   v12.4S,  v22.8h,  v31.8h
   ldr q26, [x4, #42*16]
   SMLAL    v14.4S,  v17.4h,  v24.4h
   ldr q21, [x4, #13*16]
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   ldr q18, [x4, #10*16]
   SMLAL    v11.4S,  v23.4h,  v30.4h
   ldr q29, [x4, #45*16]
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #65*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #77*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   ldr q19, [x4, #11*16]
   SMULL2   v15.4S,  v16.8h,  v26.8h
   ldr q20, [x4, #12*16]
   SMULL    v11.4S,  v21.4h,  v31.4h
   ldr q27, [x4, #43*16]
   SMULL2   v12.4S,  v21.8h,  v31.8h
   ldr q28, [x4, #44*16]
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #66*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #76*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #67*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #75*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #68*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #74*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #69*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #73*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #70*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #72*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #71*16]


   //load a5 = a2 + a3
   ldr q16, [x4, #16*16]
   //load b5 = b2 + b3
   ldr q24, [x4, #48*16]

   //a4b4
   //;v8, v9 = 464722, 4621
   mov      w5,  #4621
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h
   ldr q23, [x4, #23*16]
   SMULL2   v15.4S,  v16.8h,  v24.8h
   ldr q31, [x4, #55*16]
   SMULL    v11.4S,  v23.4h,  v31.4h
   ldr q25, [x4, #49*16]
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x1752
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #80*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #94*16]

   //;c[1] c[13]
   SMULL    v14.4S,  v16.4h,  v25.4h
   ldr q22, [x4, #22*16]
   SMULL2   v15.4S,  v16.8h,  v25.8h
   ldr q17, [x4, #17*16]
   SMULL    v11.4S,  v22.4h,  v31.4h
   ldr q30, [x4, #54*16]
   SMULL2   v12.4S,  v22.8h,  v31.8h
   ldr q26, [x4, #50*16]
   SMLAL    v14.4S,  v17.4h,  v24.4h
   ldr q21, [x4, #21*16]
   SMLAL2   v15.4S,  v17.8h,  v24.8h
   ldr q18, [x4, #18*16]
   SMLAL    v11.4S,  v23.4h,  v30.4h
   ldr q29, [x4, #53*16]
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #81*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #93*16]

   //;c[2] c[12]
   SMULL    v14.4S,  v16.4h,  v26.4h
   ldr q19, [x4, #19*16]
   SMULL2   v15.4S,  v16.8h,  v26.8h
   ldr q20, [x4, #20*16]
   SMULL    v11.4S,  v21.4h,  v31.4h
   ldr q27, [x4, #51*16]
   SMULL2   v12.4S,  v21.8h,  v31.8h
   ldr q28, [x4, #52*16]
   SMLAL    v14.4S,  v17.4h,  v25.4h
   SMLAL2   v15.4S,  v17.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v30.4h
   SMLAL2   v12.4S,  v22.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v24.4h
   SMLAL2   v15.4S,  v18.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v29.4h
   SMLAL2   v12.4S,  v23.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #82*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #92*16]

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMULL    v11.4S,  v20.4h,  v31.4h
   SMULL2   v12.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v30.4h
   SMLAL2   v12.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v29.4h
   SMLAL2   v12.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v28.4h
   SMLAL2   v12.4S,  v23.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #83*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #91*16]

   //;c[4] c[10]
   SMULL    v14.4S,  v16.4h,  v28.4h
   SMULL2   v15.4S,  v16.8h,  v28.8h
   SMULL    v11.4S,  v19.4h,  v31.4h
   SMULL2   v12.4S,  v19.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v27.4h
   SMLAL2   v15.4S,  v17.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v30.4h
   SMLAL2   v12.4S,  v20.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v26.4h
   SMLAL2   v15.4S,  v18.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v29.4h
   SMLAL2   v12.4S,  v21.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v25.4h
   SMLAL2   v15.4S,  v19.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v28.4h
   SMLAL2   v12.4S,  v22.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v24.4h
   SMLAL2   v15.4S,  v20.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v27.4h
   SMLAL2   v12.4S,  v23.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #84*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #90*16]

   //;c[5] c[9]
   SMULL    v14.4S,  v16.4h,  v29.4h
   SMULL2   v15.4S,  v16.8h,  v29.8h
   SMULL    v11.4S,  v18.4h,  v31.4h
   SMULL2   v12.4S,  v18.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v28.4h
   SMLAL2   v15.4S,  v17.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v30.4h
   SMLAL2   v12.4S,  v19.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v27.4h
   SMLAL2   v15.4S,  v18.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v29.4h
   SMLAL2   v12.4S,  v20.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v26.4h
   SMLAL2   v15.4S,  v19.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v28.4h
   SMLAL2   v12.4S,  v21.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v25.4h
   SMLAL2   v15.4S,  v20.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v27.4h
   SMLAL2   v12.4S,  v22.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v24.4h
   SMLAL2   v15.4S,  v21.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v26.4h
   SMLAL2   v12.4S,  v23.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #85*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #89*16]

   //;c[6] c[8]
   SMULL    v14.4S,  v16.4h,  v30.4h
   SMULL2   v15.4S,  v16.8h,  v30.8h
   SMULL    v11.4S,  v17.4h,  v31.4h
   SMULL2   v12.4S,  v17.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v29.4h
   SMLAL2   v15.4S,  v17.8h,  v29.8h
   SMLAL    v11.4S,  v18.4h,  v30.4h
   SMLAL2   v12.4S,  v18.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v28.4h
   SMLAL2   v15.4S,  v18.8h,  v28.8h
   SMLAL    v11.4S,  v19.4h,  v29.4h
   SMLAL2   v12.4S,  v19.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v27.4h
   SMLAL2   v15.4S,  v19.8h,  v27.8h
   SMLAL    v11.4S,  v20.4h,  v28.4h
   SMLAL2   v12.4S,  v20.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v26.4h
   SMLAL2   v15.4S,  v20.8h,  v26.8h
   SMLAL    v11.4S,  v21.4h,  v27.4h
   SMLAL2   v12.4S,  v21.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v25.4h
   SMLAL2   v15.4S,  v21.8h,  v25.8h
   SMLAL    v11.4S,  v22.4h,  v26.4h
   SMLAL2   v12.4S,  v22.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v24.4h
   SMLAL2   v15.4S,  v22.8h,  v24.8h
   SMLAL    v11.4S,  v23.4h,  v25.4h
   SMLAL2   v12.4S,  v23.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x3, #86*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #88*16]

   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2   v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2   v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2   v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2   v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2   v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2   v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2   v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2   v15.4S,  v23.8h,  v24.8h

   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      q13,     [x3, #87*16]

   //Butterfly & itranspose
   //[16-23] = arg0 = mc[1][i+8] + mc[2][i];
   //load mc[1][i+8]
   ldr q16, [x3, #24*16]
   ldr q17, [x3, #25*16]
   ldr q18, [x3, #26*16]
   ldr q19, [x3, #27*16]
   ldr q20, [x3, #28*16]
   ldr q21, [x3, #29*16]
   ldr q22, [x3, #30*16]
   ldr q23, [x3, #31*16]
   //load mc[2][i]
   ldr q8, [x3, #32*16]
   ldr q9, [x3, #33*16]
   ldr q10, [x3, #34*16]
   ldr q11, [x3, #35*16]
   ldr q12, [x3, #36*16]
   ldr q13, [x3, #37*16]
   ldr q14, [x3, #38*16]
   ldr q15, [x3, #39*16]
   ADD v16.8h, v16.8h, v8.8h
   ADD v17.8h, v17.8h, v9.8h
   ADD v18.8h, v18.8h, v10.8h
   ADD v19.8h, v19.8h, v11.8h
   ADD v20.8h, v20.8h, v12.8h
   ADD v21.8h, v21.8h, v13.8h
   ADD v22.8h, v22.8h, v14.8h
   ADD v23.8h, v23.8h, v15.8h


   //[24-31] = arg3 = mc[2][i+8] - mc[3][i];
   //load mc[2][i+8]
   ldr q24, [x3, #40*16]
   ldr q25, [x3, #41*16]
   ldr q26, [x3, #42*16]
   ldr q27, [x3, #43*16]
   ldr q28, [x3, #44*16]
   ldr q29, [x3, #45*16]
   ldr q30, [x3, #46*16]
   ldr q31, [x3, #47*16]
   //load mc[3][i]
   ldr q8, [x3, #48*16]
   ldr q9, [x3, #49*16]
   ldr q10, [x3, #50*16]
   ldr q11, [x3, #51*16]
   ldr q12, [x3, #52*16]
   ldr q13, [x3, #53*16]
   ldr q14, [x3, #54*16]
   ldr q15, [x3, #55*16]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h
   SUB v28.8h, v28.8h, v12.8h
   SUB v29.8h, v29.8h, v13.8h
   SUB v30.8h, v30.8h, v14.8h
   SUB v31.8h, v31.8h, v15.8h

   //[0-7] = out[3][i]   = mc[5][i+8] - arg3
   //load mc[5][i+8]
   ldr q0, [x3, #88*16]
   ldr q1, [x3, #89*16]
   ldr q2, [x3, #90*16]
   ldr q3, [x3, #91*16]
   ldr q4, [x3, #92*16]
   ldr q5, [x3, #93*16]
   ldr q6, [x3, #94*16]
   ldr q7, [x3, #95*16]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h
   SUB v4.8h, v4.8h, v28.8h
   SUB v5.8h, v5.8h, v29.8h
   SUB v6.8h, v6.8h, v30.8h
   SUB v7.8h, v7.8h, v31.8h

   //[24-31] = arg4 = arg3   +  mc[5][i]
   //load  mc[5][i]
   ldr q8, [x3, #80*16]
   ldr q9, [x3, #81*16]
   ldr q10, [x3, #82*16]
   ldr q11, [x3, #83*16]
   ldr q12, [x3, #84*16]
   ldr q13, [x3, #85*16]
   ldr q14, [x3, #86*16]
   ldr q15, [x3, #87*16]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   ADD v28.8h, v28.8h, v12.8h
   ADD v29.8h, v29.8h, v13.8h
   ADD v30.8h, v30.8h, v14.8h
   ADD v31.8h, v31.8h, v15.8h
   SUB v24.8h, v24.8h, v16.8h
   SUB v25.8h, v25.8h, v17.8h
   SUB v26.8h, v26.8h, v18.8h
   SUB v27.8h, v27.8h, v19.8h
   SUB v28.8h, v28.8h, v20.8h
   SUB v29.8h, v29.8h, v21.8h
   SUB v30.8h, v30.8h, v22.8h
   SUB v31.8h, v31.8h, v23.8h

   //store arg0 in mc[1][i+8] [16-23]
   str q16, [x3, #24*16]
   str q17, [x3, #25*16]
   str q18, [x3, #26*16]
   str q19, [x3, #27*16]
   str q20, [x3, #28*16]
   str q21, [x3, #29*16]
   str q22, [x3, #30*16]
   str q23, [x3, #31*16]

   //store arg4 in mc[2][i]   [24-31]
   str q24, [x3, #32*16]
   str q25, [x3, #33*16]
   str q26, [x3, #34*16]
   str q27, [x3, #35*16]
   str q28, [x3, #36*16]
   str q29, [x3, #37*16]
   str q30, [x3, #38*16]
   str q31, [x3, #39*16]

   //[24-31] out[2][i+8] = arg4 - mc[3][i+8];
   //load  mc[3][i+8]
   ldr q8, [x3, #56*16]
   ldr q9, [x3, #57*16]
   ldr q10, [x3, #58*16]
   ldr q11, [x3, #59*16]
   ldr q12, [x3, #60*16]
   ldr q13, [x3, #61*16]
   ldr q14, [x3, #62*16]
   ldr q15, [x3, #63*16]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h
   SUB v28.8h, v28.8h, v12.8h
   SUB v29.8h, v29.8h, v13.8h
   SUB v30.8h, v30.8h, v14.8h
   SUB v31.8h, v31.8h, v15.8h

   //[0-7] = out[3][i]   = mc[5][i+8] - arg3 - mc[3][i+8];
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   SUB v4.8h, v4.8h, v12.8h
   SUB v5.8h, v5.8h, v13.8h
   SUB v6.8h, v6.8h, v14.8h
   SUB v7.8h, v7.8h, v15.8h

   //itranspose & store out[3][i+8] = mc[3][i+8]
   trn1 v16.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn2 v23.8h, v11.8h, v15.8h

   str q16, [x0, #0*128+112]
   str q17, [x0, #1*128+112]
   str q18, [x0, #2*128+112]
   str q19, [x0, #3*128+112]
   str q20, [x0, #4*128+112]
   str q21, [x0, #5*128+112]
   str q22, [x0, #6*128+112]
   str q23, [x0, #7*128+112]

   //out[2][i+8] = barrett_fake(arg4 - mc[3][i+8] + mc[7][i+8]);
   //load  [8-15] = mc[7][i+8]
   ldr q8, [x3, #120*16]
   ADD v24.8h, v24.8h, v8.8h

   //barrett
   //;v18, v19 = 7, 4621
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v24.8h,  v18.8h
   mov      w9,  #4621
   DUP      v19.8H,  w9
   ldr q9, [x3, #121*16]
   ADD v25.8h, v25.8h, v9.8h
   MLS      v24.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v25.8h,  v18.8h
   ldr q10, [x3, #122*16]
   ADD v26.8h, v26.8h, v10.8h
   MLS      v25.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v26.8h,  v18.8h
   ldr q11, [x3, #123*16]
   ADD v27.8h, v27.8h, v11.8h
   MLS      v26.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v27.8h,  v18.8h
   ldr q12, [x3, #124*16]
   ADD v28.8h, v28.8h, v12.8h
   MLS      v27.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   ldr q13, [x3, #125*16]
   ADD v29.8h, v29.8h, v13.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   ldr q14, [x3, #126*16]
   ADD v30.8h, v30.8h, v14.8h
   MLS      v29.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v30.8h,  v18.8h
   ldr q15, [x3, #127*16]
   ADD v31.8h, v31.8h, v15.8h
   MLS      v30.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v31.8h,  v18.8h
   MLS      v31.8h, v16.8h,  v19.8h
   
   //itranspose & store out[2][i+8]
   trn1 v16.2d, v24.2d, v28.2d
   trn1 v18.2d, v25.2d, v29.2d
   trn1 v20.2d, v26.2d, v30.2d
   trn1 v22.2d, v27.2d, v31.2d
   trn2 v17.2d, v24.2d, v28.2d
   trn2 v19.2d, v25.2d, v29.2d
   trn2 v21.2d, v26.2d, v30.2d
   trn2 v23.2d, v27.2d, v31.2d

   trn1 v24.4s, v16.4s, v20.4s
   trn1 v26.4s, v17.4s, v21.4s
   trn1 v28.4s, v18.4s, v22.4s
   trn1 v30.4s, v19.4s, v23.4s
   trn2 v25.4s, v16.4s, v20.4s
   trn2 v27.4s, v17.4s, v21.4s
   trn2 v29.4s, v18.4s, v22.4s
   trn2 v31.4s, v19.4s, v23.4s

   trn1 v16.8h, v24.8h, v28.8h
   trn1 v18.8h, v25.8h, v29.8h
   trn1 v20.8h, v26.8h, v30.8h
   trn1 v22.8h, v27.8h, v31.8h
   trn2 v17.8h, v24.8h, v28.8h
   trn2 v19.8h, v25.8h, v29.8h
   trn2 v21.8h, v26.8h, v30.8h
   trn2 v23.8h, v27.8h, v31.8h
   
   str q16, [x0, #0*128+80]
   str q17, [x0, #1*128+80]
   str q18, [x0, #2*128+80]
   str q19, [x0, #3*128+80]
   str q20, [x0, #4*128+80]
   str q21, [x0, #5*128+80]
   str q22, [x0, #6*128+80]
   str q23, [x0, #7*128+80]


   //[0-7]  = out[3][i]
   //barrett
   //out[2][i] = mc[8][i+8] - (mc[7][i+8] +  out[3][i])
   //;v18, v19 = 7, 4621
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v0.8h,  v18.8h
   mov      w9,  #4621
   DUP      v19.8H,  w9
   MLS      v0.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v1.8h,  v18.8h
   ADD v8.8h, v8.8h, v0.8h
   MLS      v1.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v2.8h,  v18.8h
   ADD v9.8h, v9.8h, v1.8h
   MLS      v2.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v3.8h,  v18.8h
   ADD v10.8h, v10.8h, v2.8h
   MLS      v3.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   ADD v11.8h, v11.8h, v3.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   ADD v12.8h, v12.8h, v4.8h
   MLS      v5.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v6.8h,  v18.8h
   ADD v13.8h, v13.8h, v5.8h
   MLS      v6.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v7.8h,  v18.8H
   ADD v14.8h, v14.8h, v6.8h
   MLS      v7.8h, v16.8h,  v19.8h
   ADD v15.8h, v15.8h, v7.8h


   //load mc[8][i+8]
   ldr q16, [x3, #136*16]
   ldr q17, [x3, #137*16]
   ldr q18, [x3, #138*16]
   ldr q19, [x3, #139*16]
   ldr q20, [x3, #140*16]
   ldr q21, [x3, #141*16]
   ldr q22, [x3, #142*16]
   ldr q23, [x3, #143*16]
   SUB v8.8h, v16.8h, v8.8h
   SUB v9.8h, v17.8h, v9.8h
   SUB v10.8h, v18.8h, v10.8h
   SUB v11.8h, v19.8h, v11.8h
   SUB v12.8h, v20.8h, v12.8h
   SUB v13.8h, v21.8h, v13.8h
   SUB v14.8h, v22.8h, v14.8h
   SUB v15.8h, v23.8h, v15.8h

   //itranspose & store out[3][i]
   trn1 v16.2d, v0.2d, v4.2d
   trn1 v18.2d, v1.2d, v5.2d
   trn1 v20.2d, v2.2d, v6.2d
   trn1 v22.2d, v3.2d, v7.2d
   trn2 v17.2d, v0.2d, v4.2d
   trn2 v19.2d, v1.2d, v5.2d
   trn2 v21.2d, v2.2d, v6.2d
   trn2 v23.2d, v3.2d, v7.2d

   trn1 v0.4s, v16.4s, v20.4s
   trn1 v2.4s, v17.4s, v21.4s
   trn1 v4.4s, v18.4s, v22.4s
   trn1 v6.4s, v19.4s, v23.4s
   trn2 v1.4s, v16.4s, v20.4s
   trn2 v3.4s, v17.4s, v21.4s
   trn2 v5.4s, v18.4s, v22.4s
   trn2 v7.4s, v19.4s, v23.4s

   trn1 v16.8h, v0.8h, v4.8h
   trn1 v18.8h, v1.8h, v5.8h
   trn1 v20.8h, v2.8h, v6.8h
   trn1 v22.8h, v3.8h, v7.8h
   trn2 v17.8h, v0.8h, v4.8h
   trn2 v19.8h, v1.8h, v5.8h
   trn2 v21.8h, v2.8h, v6.8h
   trn2 v23.8h, v3.8h, v7.8h
   
   str q16, [x0, #0*128+96]
   str q17, [x0, #1*128+96]
   str q18, [x0, #2*128+96]
   str q19, [x0, #3*128+96]
   str q20, [x0, #4*128+96]
   str q21, [x0, #5*128+96]
   str q22, [x0, #6*128+96]
   str q23, [x0, #7*128+96]


   //[8-15] = out[2][i]
   //[24-31]  = arg1
   //arg1 = mc[1][i] - mc[0][i+8]
   //load mc[1][i]
   ldr q24, [x3, #16*16]
   ldr q25, [x3, #17*16]
   ldr q26, [x3, #18*16]
   ldr q27, [x3, #19*16]
   ldr q28, [x3, #20*16]
   ldr q29, [x3, #21*16]
   ldr q30, [x3, #22*16]
   ldr q31, [x3, #23*16]
   //load mc[0][i+8]
   ldr q0, [x3, #8*16]
   ldr q1, [x3, #9*16]
   ldr q2, [x3, #10*16]
   ldr q3, [x3, #11*16]
   ldr q4, [x3, #12*16]
   ldr q5, [x3, #13*16]
   ldr q6, [x3, #14*16]
   ldr q7, [x3, #15*16]
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h
   SUB v28.8h, v28.8h, v4.8h
   SUB v29.8h, v29.8h, v5.8h
   SUB v30.8h, v30.8h, v6.8h
   SUB v31.8h, v31.8h, v7.8h

   //[0-7] = arg0 => arg2 = arg1 - arg0 +  mc[4][i+8]
   //load arg0
   ldr q0, [x3, #24*16]
   ldr q1, [x3, #25*16]
   ldr q2, [x3, #26*16]
   ldr q3, [x3, #27*16]
   ldr q4, [x3, #28*16]
   ldr q5, [x3, #29*16]
   ldr q6, [x3, #30*16]
   ldr q7, [x3, #31*16]
   SUB v0.8h, v24.8h, v0.8h
   SUB v1.8h, v25.8h, v1.8h
   SUB v2.8h, v26.8h, v2.8h
   SUB v3.8h, v27.8h, v3.8h
   SUB v4.8h, v28.8h, v4.8h
   SUB v5.8h, v29.8h, v5.8h
   SUB v6.8h, v30.8h, v6.8h
   SUB v7.8h, v31.8h, v7.8h
   //load mc[4][i+8] 
   ldr q16, [x3, #72*16]
   ldr q17, [x3, #73*16]
   ldr q18, [x3, #74*16]
   ldr q19, [x3, #75*16]
   ldr q20, [x3, #76*16]
   ldr q21, [x3, #77*16]
   ldr q22, [x3, #78*16]
   ldr q23, [x3, #79*16]
   ADD v0.8h, v0.8h, v16.8h
   ADD v1.8h, v1.8h, v17.8h
   ADD v2.8h, v2.8h, v18.8h
   ADD v3.8h, v3.8h, v19.8h
   ADD v4.8h, v4.8h, v20.8h
   ADD v5.8h, v5.8h, v21.8h
   ADD v6.8h, v6.8h, v22.8h
   ADD v7.8h, v7.8h, v23.8h

   //[0-7] = arg2
   //[8-15] = out[2][i] - arg2
   SUB v8.8h, v8.8h, v0.8h
   SUB v9.8h, v9.8h, v1.8h
   SUB v10.8h, v10.8h, v2.8h
   SUB v11.8h, v11.8h, v3.8h
   SUB v12.8h, v12.8h, v4.8h
   SUB v13.8h, v13.8h, v5.8h
   SUB v14.8h, v14.8h, v6.8h
   SUB v15.8h, v15.8h, v7.8h
   //store out[2][i] - arg2 
   str q8, [x3, #24*16]
   str q9, [x3, #25*16]
   str q10, [x3, #26*16]
   str q11, [x3, #27*16]
   str q12, [x3, #28*16]
   str q13, [x3, #29*16]
   str q14, [x3, #30*16]
   str q15, [x3, #31*16]

   //[8-15] = mc[0][i];
   //load mc[0][i]
   ldr q8, [x3, #0*16]
   ldr q9, [x3, #1*16]
   ldr q10, [x3, #2*16]
   ldr q11, [x3, #3*16]
   ldr q12, [x3, #4*16]
   ldr q13, [x3, #5*16]
   ldr q14, [x3, #6*16]
   ldr q15, [x3, #7*16]

   //[0-7] = arg2 - mc[0][i]
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   SUB v4.8h, v4.8h, v12.8h
   SUB v5.8h, v5.8h, v13.8h
   SUB v6.8h, v6.8h, v14.8h
   SUB v7.8h, v7.8h, v15.8h
   //[24-31] = arg1 + mc[0][i]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   ADD v28.8h, v28.8h, v12.8h
   ADD v29.8h, v29.8h, v13.8h
   ADD v30.8h, v30.8h, v14.8h
   ADD v31.8h, v31.8h, v15.8h
   //itranspose & store out[0][i] = mc[0][i]
   trn1 v16.2d, v8.2d, v12.2d
   trn1 v18.2d, v9.2d, v13.2d
   trn1 v20.2d, v10.2d, v14.2d
   trn1 v22.2d, v11.2d, v15.2d
   trn2 v17.2d, v8.2d, v12.2d
   trn2 v19.2d, v9.2d, v13.2d
   trn2 v21.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d

   trn1 v8.4s, v16.4s, v20.4s
   trn1 v10.4s, v17.4s, v21.4s
   trn1 v12.4s, v18.4s, v22.4s
   trn1 v14.4s, v19.4s, v23.4s
   trn2 v9.4s, v16.4s, v20.4s
   trn2 v11.4s, v17.4s, v21.4s
   trn2 v13.4s, v18.4s, v22.4s
   trn2 v15.4s, v19.4s, v23.4s

   trn1 v16.8h, v8.8h, v12.8h
   trn1 v18.8h, v9.8h, v13.8h
   trn1 v20.8h, v10.8h, v14.8h
   trn1 v22.8h, v11.8h, v15.8h
   trn2 v17.8h, v8.8h, v12.8h
   trn2 v19.8h, v9.8h, v13.8h
   trn2 v21.8h, v10.8h, v14.8h
   trn2 v23.8h, v11.8h, v15.8h

   str q16, [x0, #0*128]
   str q17, [x0, #1*128]
   str q18, [x0, #2*128]
   str q19, [x0, #3*128]
   str q20, [x0, #4*128]
   str q21, [x0, #5*128]
   str q22, [x0, #6*128]
   str q23, [x0, #7*128]

   //[24-31] = arg1 + mc[0][i]; [0-7] = arg2 - mc[0][i]
   //out[0][i+8] = barrett_fake(mc[4][i]   - (mc[0][i]   +  arg1));
   //load [8-15] = mc[4][i] & mc[6][i]
   ldr q8, [x3, #64*16]
   SUB v24.8h, v8.8h, v24.8h

   //out[0][i+8]
   //barrett out[0][i+8]
   //;v18, v19 = 7, 4621
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v24.8h,  v18.8h
   mov      w9,  #4621
   DUP      v19.8H,  w9
   ldr q9, [x3, #65*16]
   SUB v25.8h, v9.8h, v25.8h
   MLS      v24.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v25.8h,  v18.8h
   ldr q8, [x3, #96*16]
   ADD v0.8h, v0.8h, v8.8h
   ldr q10, [x3, #66*16]
   SUB v26.8h, v10.8h, v26.8h
   ADD v8.8h, v8.8h, v24.8h
   MLS      v25.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v26.8h,  v18.8h
   ldr q9, [x3, #97*16]
   ADD v1.8h, v1.8h, v9.8h
   ldr q11, [x3, #67*16]
   SUB v27.8h, v11.8h, v27.8h
   ADD v9.8h, v9.8h, v25.8h
   MLS      v26.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v27.8h,  v18.8h
   ldr q10, [x3, #98*16]
   ADD v2.8h, v2.8h, v10.8h
   ldr q12, [x3, #68*16]
   SUB v28.8h, v12.8h, v28.8h
   ADD v10.8h, v10.8h, v26.8h
   MLS      v27.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   ldr q11, [x3, #99*16]
   ADD v3.8h, v3.8h, v11.8h
   ldr q13, [x3, #69*16]
   ADD v11.8h, v11.8h, v27.8h
   SUB v29.8h, v13.8h, v29.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   ldr q12, [x3, #100*16]
   ADD v4.8h, v4.8h, v12.8h
   ldr q14, [x3, #70*16]
   SUB v30.8h, v14.8h, v30.8h
   ADD v12.8h, v12.8h, v28.8h
   MLS      v29.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v30.8h,  v18.8h
   ldr q13, [x3, #101*16]
   ADD v5.8h, v5.8h, v13.8h
   ldr q15, [x3, #71*16]
   SUB v31.8h, v15.8h, v31.8h
   ADD v13.8h, v13.8h, v29.8h
   MLS      v30.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v31.8h,  v18.8h
   ldr q14, [x3, #102*16]
   ADD v6.8h, v6.8h, v14.8h
   ldr q15, [x3, #103*16]
   ADD v7.8h, v7.8h, v15.8h
   ADD v14.8h, v14.8h, v30.8h
   ADD v15.8h, v15.8h, v31.8h
   MLS      v31.8h, v16.8h,  v19.8h
   

   //[0-7] = out[1][i] = arg2 - mc[0][i] + mc[6][i]
   //[8-15] mc[6][i] + out[0][i+8]
   //itranspose & store out[0][i+8]
   trn1 v16.2d, v24.2d, v28.2d
   trn1 v18.2d, v25.2d, v29.2d
   trn1 v20.2d, v26.2d, v30.2d
   trn1 v22.2d, v27.2d, v31.2d
   trn2 v17.2d, v24.2d, v28.2d
   trn2 v19.2d, v25.2d, v29.2d
   trn2 v21.2d, v26.2d, v30.2d
   trn2 v23.2d, v27.2d, v31.2d

   trn1 v24.4s, v16.4s, v20.4s
   trn1 v26.4s, v17.4s, v21.4s
   trn1 v28.4s, v18.4s, v22.4s
   trn1 v30.4s, v19.4s, v23.4s
   trn2 v25.4s, v16.4s, v20.4s
   trn2 v27.4s, v17.4s, v21.4s
   trn2 v29.4s, v18.4s, v22.4s
   trn2 v31.4s, v19.4s, v23.4s

   trn1 v16.8h, v24.8h, v28.8h
   trn1 v18.8h, v25.8h, v29.8h
   trn1 v20.8h, v26.8h, v30.8h
   trn1 v22.8h, v27.8h, v31.8h
   trn2 v17.8h, v24.8h, v28.8h
   trn2 v19.8h, v25.8h, v29.8h
   trn2 v21.8h, v26.8h, v30.8h
   trn2 v23.8h, v27.8h, v31.8h

   str q16, [x0, #0*128+16]
   str q17, [x0, #1*128+16]
   str q18, [x0, #2*128+16]
   str q19, [x0, #3*128+16]
   str q20, [x0, #4*128+16]
   str q21, [x0, #5*128+16]
   str q22, [x0, #6*128+16]
   str q23, [x0, #7*128+16]

   //[0-7]barrett_fake(out[1][i])
   mov      w9,  #4621
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v0.8h,  v18.8h
   MLS      v0.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v1.8h,  v18.8h
   MLS      v1.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v2.8h,  v18.8h
   MLS      v2.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v3.8h,  v18.8h
   MLS      v3.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v6.8h,  v18.8h
   MLS      v6.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v7.8h,  v18.8h
   MLS      v7.8h, v16.8h,  v19.8h
   //itranspose & store out[1][i]
   trn1 v16.2d, v0.2d, v4.2d
   trn1 v18.2d, v1.2d, v5.2d
   trn1 v20.2d, v2.2d, v6.2d
   trn1 v22.2d, v3.2d, v7.2d
   trn2 v17.2d, v0.2d, v4.2d
   trn2 v19.2d, v1.2d, v5.2d
   trn2 v21.2d, v2.2d, v6.2d
   trn2 v23.2d, v3.2d, v7.2d

   trn1 v0.4s, v16.4s, v20.4s
   trn1 v2.4s, v17.4s, v21.4s
   trn1 v4.4s, v18.4s, v22.4s
   trn1 v6.4s, v19.4s, v23.4s
   trn2 v1.4s, v16.4s, v20.4s
   trn2 v3.4s, v17.4s, v21.4s
   trn2 v5.4s, v18.4s, v22.4s
   trn2 v7.4s, v19.4s, v23.4s

   trn1 v16.8h, v0.8h, v4.8h
   trn1 v18.8h, v1.8h, v5.8h
   trn1 v20.8h, v2.8h, v6.8h
   trn1 v22.8h, v3.8h, v7.8h
   trn2 v17.8h, v0.8h, v4.8h
   trn2 v19.8h, v1.8h, v5.8h
   trn2 v21.8h, v2.8h, v6.8h
   trn2 v23.8h, v3.8h, v7.8h

   str q16, [x0, #0*128+32]
   str q17, [x0, #1*128+32]
   str q18, [x0, #2*128+32]
   str q19, [x0, #3*128+32]
   str q20, [x0, #4*128+32]
   str q21, [x0, #5*128+32]
   str q22, [x0, #6*128+32]
   str q23, [x0, #7*128+32]

   //[8-15] mc[6][i] + out[0][i+8]
   //[0-7] arg5 = mc[6][i+8] - mc[7][i];
   //load mc[6][i+8]
   ldr q0, [x3, #104*16]
   ldr q1, [x3, #105*16]
   ldr q2, [x3, #106*16]
   ldr q3, [x3, #107*16]
   ldr q4, [x3, #108*16]
   ldr q5, [x3, #109*16]
   ldr q6, [x3, #110*16]
   ldr q7, [x3, #111*16]
   //load mc[7][i]
   ldr q16, [x3, #112*16]
   ldr q17, [x3, #113*16]
   ldr q18, [x3, #114*16]
   ldr q19, [x3, #115*16]
   ldr q20, [x3, #116*16]
   ldr q21, [x3, #117*16]
   ldr q22, [x3, #118*16]
   ldr q23, [x3, #119*16]
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h
   SUB v4.8h, v4.8h, v20.8h
   SUB v5.8h, v5.8h, v21.8h
   SUB v6.8h, v6.8h, v22.8h
   SUB v7.8h, v7.8h, v23.8h


   //[24-31] =  out[2][i] - arg2
   //load out[2][i] - arg2
   //out[2][i] - arg2 - arg5
   ldr q24, [x3, #24*16]
   SUB v24.8h, v24.8h, v0.8h

   //barrett out[2][i]
   mov      w9,  #4621
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v24.8h,  v18.8h
   ldr q25, [x3, #25*16]
   SUB v25.8h, v25.8h, v1.8h
   MLS      v24.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v25.8h,  v18.8h
   ldr q26, [x3, #26*16]
   SUB v26.8h, v26.8h, v2.8h
   MLS      v25.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v26.8h,  v18.8h
   ldr q27, [x3, #27*16]
   SUB v27.8h, v27.8h, v3.8h
   MLS      v26.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v27.8h,  v18.8h
   ldr q28, [x3, #28*16]
   SUB v28.8h, v28.8h, v4.8h
   MLS      v27.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   ldr q29, [x3, #29*16]
   SUB v29.8h, v29.8h, v5.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   ldr q30, [x3, #30*16]
   SUB v30.8h, v30.8h, v6.8h
   MLS      v29.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v30.8h,  v18.8h
   ldr q31, [x3, #31*16]
   SUB v31.8h, v31.8h, v7.8h
   MLS      v30.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v31.8h,  v18.8h
   MLS      v31.8h, v16.8h,  v19.8h
   //itranspose & store out[2][i]
   trn1 v16.2d, v24.2d, v28.2d
   trn1 v18.2d, v25.2d, v29.2d
   trn1 v20.2d, v26.2d, v30.2d
   trn1 v22.2d, v27.2d, v31.2d
   trn2 v17.2d, v24.2d, v28.2d
   trn2 v19.2d, v25.2d, v29.2d
   trn2 v21.2d, v26.2d, v30.2d
   trn2 v23.2d, v27.2d, v31.2d

   trn1 v24.4s, v16.4s, v20.4s
   trn1 v26.4s, v17.4s, v21.4s
   trn1 v28.4s, v18.4s, v22.4s
   trn1 v30.4s, v19.4s, v23.4s
   trn2 v25.4s, v16.4s, v20.4s
   trn2 v27.4s, v17.4s, v21.4s
   trn2 v29.4s, v18.4s, v22.4s
   trn2 v31.4s, v19.4s, v23.4s

   trn1 v16.8h, v24.8h, v28.8h
   trn1 v18.8h, v25.8h, v29.8h
   trn1 v20.8h, v26.8h, v30.8h
   trn1 v22.8h, v27.8h, v31.8h
   trn2 v17.8h, v24.8h, v28.8h
   trn2 v19.8h, v25.8h, v29.8h
   trn2 v21.8h, v26.8h, v30.8h
   trn2 v23.8h, v27.8h, v31.8h

   str q16, [x0, #0*128+64]
   str q17, [x0, #1*128+64]
   str q18, [x0, #2*128+64]
   str q19, [x0, #3*128+64]
   str q20, [x0, #4*128+64]
   str q21, [x0, #5*128+64]
   str q22, [x0, #6*128+64]
   str q23, [x0, #7*128+64]

   //[8-15] mc[6][i] + out[0][i+8]; [0-7] = arg5
   //out[1][i+8] = barrett_fake(arg5 + mc[8][i]   - (arg4 + mc[6][i] + out[0][i+8]));
   //load mc[8][i] 
   ldr q24, [x3, #128*16]
   ldr q25, [x3, #129*16]
   ldr q26, [x3, #130*16]
   ldr q27, [x3, #131*16]
   ldr q28, [x3, #132*16]
   ldr q29, [x3, #133*16]
   ldr q30, [x3, #134*16]
   ldr q31, [x3, #135*16]
   ADD v0.8h, v0.8h, v24.8h
   ADD v1.8h, v1.8h, v25.8h
   ADD v2.8h, v2.8h, v26.8h
   ADD v3.8h, v3.8h, v27.8h
   ADD v4.8h, v4.8h, v28.8h
   ADD v5.8h, v5.8h, v29.8h
   ADD v6.8h, v6.8h, v30.8h
   ADD v7.8h, v7.8h, v31.8h
   //load arg4 
   ldr q24, [x3, #32*16]
   ldr q25, [x3, #33*16]
   ldr q26, [x3, #34*16]
   ldr q27, [x3, #35*16]
   ldr q28, [x3, #36*16]
   ldr q29, [x3, #37*16]
   ldr q30, [x3, #38*16]
   ldr q31, [x3, #39*16]
   //(arg4 + mc[6][i] + out[0][i+8])
   //out[1][i+8]
   ADD v24.8h, v24.8h, v8.8h
   SUB v0.8h, v0.8h, v24.8h


   //barrett out[1][i+8]
   mov      w9,  #4621
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v0.8h,  v18.8h
   ADD v25.8h, v25.8h, v9.8h
   SUB v1.8h, v1.8h, v25.8h
   MLS      v0.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v1.8h,  v18.8h
   ADD v26.8h, v26.8h, v10.8h
   SUB v2.8h, v2.8h, v26.8h
   MLS      v1.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v2.8h,  v18.8h
   ADD v27.8h, v27.8h, v11.8h
   SUB v3.8h, v3.8h, v27.8h
   MLS      v2.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v3.8h,  v18.8h
   ADD v28.8h, v28.8h, v12.8h
   SUB v4.8h, v4.8h, v28.8h
   MLS      v3.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   ADD v29.8h, v29.8h, v13.8h
   SUB v5.8h, v5.8h, v29.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   ADD v30.8h, v30.8h, v14.8h
   SUB v6.8h, v6.8h, v30.8h
   MLS      v5.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v6.8h,  v18.8h
   ADD v31.8h, v31.8h, v15.8h
   SUB v7.8h, v7.8h, v31.8h
   MLS      v6.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v7.8h,  v18.8h
   MLS      v7.8h, v16.8h,  v19.8h
   //itranspose & store out[1][i+8]
   trn1 v16.2d, v0.2d, v4.2d
   trn1 v18.2d, v1.2d, v5.2d
   trn1 v20.2d, v2.2d, v6.2d
   trn1 v22.2d, v3.2d, v7.2d
   trn2 v17.2d, v0.2d, v4.2d
   trn2 v19.2d, v1.2d, v5.2d
   trn2 v21.2d, v2.2d, v6.2d
   trn2 v23.2d, v3.2d, v7.2d

   trn1 v0.4s, v16.4s, v20.4s
   trn1 v2.4s, v17.4s, v21.4s
   trn1 v4.4s, v18.4s, v22.4s
   trn1 v6.4s, v19.4s, v23.4s
   trn2 v1.4s, v16.4s, v20.4s
   trn2 v3.4s, v17.4s, v21.4s
   trn2 v5.4s, v18.4s, v22.4s
   trn2 v7.4s, v19.4s, v23.4s

   trn1 v16.8h, v0.8h, v4.8h
   trn1 v18.8h, v1.8h, v5.8h
   trn1 v20.8h, v2.8h, v6.8h
   trn1 v22.8h, v3.8h, v7.8h
   trn2 v17.8h, v0.8h, v4.8h
   trn2 v19.8h, v1.8h, v5.8h
   trn2 v21.8h, v2.8h, v6.8h
   trn2 v23.8h, v3.8h, v7.8h

   str q16, [x0, #0*128+48]
   str q17, [x0, #1*128+48]
   str q18, [x0, #2*128+48]
   str q19, [x0, #3*128+48]
   str q20, [x0, #4*128+48]
   str q21, [x0, #5*128+48]
   str q22, [x0, #6*128+48]
   str q23, [x0, #7*128+48]

   ret