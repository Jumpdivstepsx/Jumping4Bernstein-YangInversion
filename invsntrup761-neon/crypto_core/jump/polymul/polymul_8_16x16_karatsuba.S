.align 6
.global __asm8_16x16
.global ___asm8_16x16
__asm8_16x16:
___asm8_16x16:

   //a0:v16-v23
   ldr q8, [x1, #0*32]
   ldr q9, [x1, #1*32]
   ldr q10, [x1, #2*32]
   ldr q11, [x1, #3*32]
   ldr q12, [x1, #4*32]
   ldr q13, [x1, #5*32]
   ldr q14, [x1, #6*32]
   ldr q15, [x1, #7*32]

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
   ldr q8, [x2, #0*32]
   ldr q9, [x2, #1*32]
   ldr q10, [x2, #2*32]
   ldr q11, [x2, #3*32]
   ldr q12, [x2, #4*32]
   ldr q13, [x2, #5*32]
   ldr q14, [x2, #6*32]
   ldr q15, [x2, #7*32]

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

   //a0b0 [16-23 * 24-31]
   //;v8, v9 = 467759, 4591
   mov      w5,  #4591
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x232f
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
   ldr q8, [x1, #0*32+16]
   ldr q9, [x1, #1*32+16]
   ldr q10, [x1, #2*32+16]
   ldr q11, [x1, #3*32+16]
   ldr q12, [x1, #4*32+16]
   ldr q13, [x1, #5*32+16]
   ldr q14, [x1, #6*32+16]
   ldr q15, [x1, #7*32+16]

   trn1 v0.2d, v8.2d, v12.2d
   trn2 v1.2d, v8.2d, v12.2d
   trn1 v2.2d, v9.2d, v13.2d
   trn2 v3.2d, v9.2d, v13.2d
   trn1 v4.2d, v10.2d, v14.2d
   trn2 v5.2d, v10.2d, v14.2d
   trn1 v6.2d, v11.2d, v15.2d
   trn2 v7.2d, v11.2d, v15.2d

   trn1 v8.4s, v0.4s, v4.4s
   trn2 v9.4s, v0.4s, v4.4s
   trn1 v10.4s, v1.4s, v5.4s
   trn2 v11.4s, v1.4s, v5.4s
   trn1 v12.4s, v2.4s, v6.4s
   trn2 v13.4s, v2.4s, v6.4s
   trn1 v14.4s, v3.4s, v7.4s
   trn2 v15.4s, v3.4s, v7.4s

   trn1 v0.8h, v8.8h, v12.8h
   trn2 v1.8h, v8.8h, v12.8h
   trn1 v2.8h, v9.8h, v13.8h
   trn2 v3.8h, v9.8h, v13.8h
   trn1 v4.8h, v10.8h, v14.8h
   trn2 v5.8h, v10.8h, v14.8h
   trn1 v6.8h, v11.8h, v15.8h
   trn2 v7.8h, v11.8h, v15.8h

   //a0+a1:v16-v23
   ADD v16.8h, v16.8h, v0.8h
   ADD v17.8h, v17.8h, v1.8h
   ADD v18.8h, v18.8h, v2.8h
   ADD v19.8h, v19.8h, v3.8h
   ADD v20.8h, v20.8h, v4.8h
   ADD v21.8h, v21.8h, v5.8h
   ADD v22.8h, v22.8h, v6.8h
   ADD v23.8h, v23.8h, v7.8h
   
   //store a0+a1
   str q16, [x3, #768+0*16]
   str q17, [x3, #768+1*16]
   str q18, [x3, #768+2*16]
   str q19, [x3, #768+3*16]
   str q20, [x3, #768+4*16]
   str q21, [x3, #768+5*16]
   str q22, [x3, #768+6*16]
   str q23, [x3, #768+7*16]

   //b0:v16-v23
   ldr q8, [x2, #0*32+16]
   ldr q9, [x2, #1*32+16]
   ldr q10, [x2, #2*32+16]
   ldr q11, [x2, #3*32+16]
   ldr q12, [x2, #4*32+16]
   ldr q13, [x2, #5*32+16]
   ldr q14, [x2, #6*32+16]
   ldr q15, [x2, #7*32+16]

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

   //a1b1 [0-7 * 16-23]
   //;v8, v9 = 467759, 4591
   mov      w5,  #4591
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v0.4h   
   SMULL2   v15.4S,  v16.8h,  v0.8h
   SMULL    v11.4S,  v23.4h,  v7.4h
   SMULL2   v12.4S,  v23.8h,  v7.8h
   mov      w7, #0x232f
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
   STR      q13,     [x3, #0*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #14*16+256]

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
   STR      q13,     [x3, #1*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #13*16+256]

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
   STR      q13,     [x3, #2*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #12*16+256]

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
   STR      q13,     [x3, #3*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #11*16+256]

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
   STR      q13,     [x3, #4*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #10*16+256]

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
   STR      q13,     [x3, #5*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #9*16+256]

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
   STR      q13,     [x3, #6*16+256]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #8*16+256]

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
   STR      q13,     [x3, #7*16+256]

   //b0+b1:v24-v31
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h

   //load a0+a1
   ldr q16, [x3, #768+0*16]
   ldr q17, [x3, #768+1*16]
   ldr q18, [x3, #768+2*16]
   ldr q19, [x3, #768+3*16]
   ldr q20, [x3, #768+4*16]
   ldr q21, [x3, #768+5*16]
   ldr q22, [x3, #768+6*16]
   ldr q23, [x3, #768+7*16]


   //(a0+a1)(b0+b1) [16-23 * 24-31]
   //;v8, v9 = 467759, 4591
   mov      w5,  #4591
   DUP      v9.8H,  w5

   // ;low, high, reduce = v14, v15, v13
   //;c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   mov      w7, #0x232f
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
   STR      q13,     [x3, #0*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #14*16+512]

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
   STR      q13,     [x3, #1*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #13*16+512]

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
   STR      q13,     [x3, #2*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #12*16+512]

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
   STR      q13,     [x3, #3*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #11*16+512]

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
   STR      q13,     [x3, #4*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #10*16+512]

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
   STR      q13,     [x3, #5*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #9*16+512]

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
   STR      q13,     [x3, #6*16+512]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x3, #8*16+512]

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
   STR      q13,     [x3, #7*16+512]

   //load c00:v0-v7
   ldr q0, [x3, #0*16]
   ldr q1, [x3, #1*16]
   ldr q2, [x3, #2*16]
   ldr q3, [x3, #3*16]
   ldr q4, [x3, #4*16]
   ldr q5, [x3, #5*16]
   ldr q6, [x3, #6*16]
   ldr q7, [x3, #7*16]

   //load c10:v24-v31
   ldr q24, [x3, #0*16+512]
   ldr q25, [x3, #1*16+512]
   ldr q26, [x3, #2*16+512]
   ldr q27, [x3, #3*16+512]
   ldr q28, [x3, #4*16+512]
   ldr q29, [x3, #5*16+512]
   ldr q30, [x3, #6*16+512]
   ldr q31, [x3, #7*16+512]

   //C1 = c10 - c00
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h
   SUB v28.8h, v28.8h, v4.8h
   SUB v29.8h, v29.8h, v5.8h
   SUB v30.8h, v30.8h, v6.8h
   SUB v31.8h, v31.8h, v7.8h

   //C0
   //itranspose & store
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

   str q16, [x0, #0*64]
   str q17, [x0, #1*64]
   str q18, [x0, #2*64]
   str q19, [x0, #3*64]
   str q20, [x0, #4*64]
   str q21, [x0, #5*64]
   str q22, [x0, #6*64]
   str q23, [x0, #7*64]

   //load c01:v8-v15
   ldr q8, [x3, #8*16]
   ldr q9, [x3, #9*16]
   ldr q10, [x3, #10*16]
   ldr q11, [x3, #11*16]
   ldr q12, [x3, #12*16]
   ldr q13, [x3, #13*16]
   ldr q14, [x3, #14*16]
   ldr q15, [x3, #15*16]

   //C1 = C1 + c01
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   ADD v28.8h, v28.8h, v12.8h
   ADD v29.8h, v29.8h, v13.8h
   ADD v30.8h, v30.8h, v14.8h
   ADD v31.8h, v31.8h, v15.8h

   //load c20:v0-v7
   //C01 = C01 - c20
   ldr q0, [x3, #0*16+256]
   SUB v24.8h, v24.8h, v0.8h

   //barrett out[2][i]
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v24.8h,  v18.8h
   ldr q1, [x3, #1*16+256]
   SUB v25.8h, v25.8h, v1.8h
   MLS      v24.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v25.8h,  v18.8h
   ldr q2, [x3, #2*16+256]
   SUB v26.8h, v26.8h, v2.8h
   MLS      v25.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v26.8h,  v18.8h
   ldr q3, [x3, #3*16+256]
   SUB v27.8h, v27.8h, v3.8h
   MLS      v26.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v27.8h,  v18.8h
   ldr q4, [x3, #4*16+256]
   SUB v28.8h, v28.8h, v4.8h
   MLS      v27.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   ldr q5, [x3, #5*16+256]
   SUB v29.8h, v29.8h, v5.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   ldr q6, [x3, #6*16+256]
   SUB v30.8h, v30.8h, v6.8h
   MLS      v29.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v30.8h,  v18.8h
   ldr q7, [x3, #7*16+256]
   SUB v31.8h, v31.8h, v7.8h
   MLS      v30.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v31.8h,  v18.8h
   MLS      v31.8h, v16.8h,  v19.8h
   //itranspose & store C1
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

   str q16, [x0, #0*64+16]
   str q17, [x0, #1*64+16]
   str q18, [x0, #2*64+16]
   str q19, [x0, #3*64+16]
   str q20, [x0, #4*64+16]
   str q21, [x0, #5*64+16]
   str q22, [x0, #6*64+16]
   str q23, [x0, #7*64+16]

   //C2
   //c01[8-15], c20[0-7]
   //C2 = c20 - c01
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   SUB v4.8h, v4.8h, v12.8h
   SUB v5.8h, v5.8h, v13.8h
   SUB v6.8h, v6.8h, v14.8h
   SUB v7.8h, v7.8h, v15.8h
 
   //load c21:v24-v31
   ldr q24, [x3, #8*16+256]
   ldr q25, [x3, #9*16+256]
   ldr q26, [x3, #10*16+256]
   ldr q27, [x3, #11*16+256]
   ldr q28, [x3, #12*16+256]
   ldr q29, [x3, #13*16+256]
   ldr q30, [x3, #14*16+256]
   ldr q31, [x3, #15*16+256]

   //C2 = C2 - c21
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h
   SUB v4.8h, v4.8h, v28.8h
   SUB v5.8h, v5.8h, v29.8h
   SUB v6.8h, v6.8h, v30.8h
   SUB v7.8h, v7.8h, v31.8h

   //itranspose & store C3
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

   str q16, [x0, #0*64+48]
   str q17, [x0, #1*64+48]
   str q18, [x0, #2*64+48]
   str q19, [x0, #3*64+48]
   str q20, [x0, #4*64+48]
   str q21, [x0, #5*64+48]
   str q22, [x0, #6*64+48]
   str q23, [x0, #7*64+48]

   //C2 = C2 + c11
   //load c11:v24-v31
   ldr q24, [x3, #8*16+512]
   ADD v24.8h, v24.8h, v0.8h

   //barrett out[2][i]
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   SQRDMULH v16.8h, v24.8h,  v18.8h
   ldr q25, [x3, #9*16+512]
   ADD v25.8h, v25.8h, v1.8h
   MLS      v24.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v25.8h,  v18.8h
   ldr q26, [x3, #10*16+512]
   ADD v26.8h, v26.8h, v2.8h
   MLS      v25.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v26.8h,  v18.8h
   ldr q27, [x3, #11*16+512]
   ADD v27.8h, v27.8h, v3.8h
   MLS      v26.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v27.8h,  v18.8h
   ldr q28, [x3, #12*16+512]
   ADD v28.8h, v28.8h, v4.8h
   MLS      v27.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   ldr q29, [x3, #13*16+512]
   ADD v29.8h, v29.8h, v5.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   ldr q30, [x3, #14*16+512]
   ADD v30.8h, v30.8h, v6.8h
   MLS      v29.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v30.8h,  v18.8h
   ldr q31, [x3, #15*16+512]
   ADD v31.8h, v31.8h, v7.8h
   MLS      v30.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v31.8h,  v18.8h
   MLS      v31.8h, v16.8h,  v19.8h
   //itranspose & store C2
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

   str q16, [x0, #0*64+32]
   str q17, [x0, #1*64+32]
   str q18, [x0, #2*64+32]
   str q19, [x0, #3*64+32]
   str q20, [x0, #4*64+32]
   str q21, [x0, #5*64+32]
   str q22, [x0, #6*64+32]
   str q23, [x0, #7*64+32]

   ret