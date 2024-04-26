.align 6
.global __asm_4x32x32
.global ___asm_4x32x32
.global __asm_4x32x32_x1
.global ___asm_4x32x32_x1
.global __asm_4x32x32_fx1
.global ___asm_4x32x32_fx1

__asm_4x32x32:
___asm_4x32x32:
   mov      w5,  #0
   DUP      v0.8h,  w5
   str q0, [x4, #112+0*128]
   str q0, [x4, #112+1*128]
   str q0, [x4, #112+2*128]
   str q0, [x4, #112+3*128]
   str q0, [x4, #112+4*128]
   str q0, [x4, #112+5*128]
   str q0, [x4, #112+6*128]
   str q0, [x4, #112+7*128]
   str q0, [x4, #112+8*128]
   str q0, [x4, #112+9*128]
   str q0, [x4, #112+10*128]

   //a0a1:v16-v23
   ldr q8, [x1, #0*64]
   ldr q12, [x1, #0*64+16]
   ldr q9, [x1, #1*64]
   ldr q13, [x1, #1*64+16]
   ldr q10, [x1, #2*64]
   ldr q14, [x1, #2*64+16]
   ldr q11, [x1, #3*64]
   ldr q15, [x1, #3*64+16]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d


   //b0b1:v24-v31
   ldr q8, [x2, #0]
   ldr q12, [x2, #16]
   ldr q9, [x3, #0]
   ldr q13, [x3, #16]
   ldr q10, [x2, #0]
   ldr q14, [x2, #16]
   ldr q11, [x3, #0]
   ldr q15, [x3, #16]

   trn1 v24.4s, v8.4s, v10.4s
   trn1 v26.4s, v9.4s, v11.4s
   trn1 v28.4s, v12.4s, v14.4s
   trn1 v30.4s, v13.4s, v15.4s
   trn2 v25.4s, v8.4s, v10.4s
   trn2 v27.4s, v9.4s, v11.4s
   trn2 v29.4s, v12.4s, v14.4s
   trn2 v31.4s, v13.4s, v15.4s

   trn1 v8.8h, v24.8h, v26.8h
   trn1 v10.8h, v25.8h, v27.8h
   trn1 v12.8h, v28.8h, v30.8h
   trn1 v14.8h, v29.8h, v31.8h
   trn2 v9.8h, v24.8h, v26.8h
   trn2 v11.8h, v25.8h, v27.8h
   trn2 v13.8h, v28.8h, v30.8h
   trn2 v15.8h, v29.8h, v31.8h

   trn1 v24.2d, v8.2d, v12.2d
   trn1 v25.2d, v9.2d, v13.2d
   trn1 v26.2d, v10.2d, v14.2d    
   trn1 v27.2d, v11.2d, v15.2d
   trn2 v28.2d, v8.2d, v12.2d
   trn2 v29.2d, v9.2d, v13.2d
   trn2 v30.2d, v10.2d, v14.2d    
   trn2 v31.2d, v11.2d, v15.2d

   //a0b0 [16-23] * [24-31]
   //;c[0]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+128]
   //;c[1]
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
   STR      d13,     [x4, #1*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+128]
   //;c[2]
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
   STR      d13,     [x4, #2*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+128]
   //;c[3]
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
   STR      d13,     [x4, #3*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+128]
   //;c[4]
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
   STR      d13,     [x4, #4*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+128]
   //;c[5]
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
   STR      d13,     [x4, #5*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+128]
   //;c[6]
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
   STR      d13,     [x4, #6*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+128]


   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2    v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2    v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2    v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2    v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2    v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2    v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2    v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2    v15.4S,  v23.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+128]
   

   //a2a3:v0-v7
   ldr q8, [x1, #0*64+32]
   ldr q12, [x1, #0*64+48]
   ldr q9, [x1, #1*64+32]
   ldr q13, [x1, #1*64+48]
   ldr q10, [x1, #2*64+32]
   ldr q14, [x1, #2*64+48]
   ldr q11, [x1, #3*64+32]
   ldr q15, [x1, #3*64+48]

   trn1 v0.4s, v8.4s, v10.4s
   trn1 v2.4s, v9.4s, v11.4s
   trn1 v4.4s, v12.4s, v14.4s
   trn1 v6.4s, v13.4s, v15.4s
   trn2 v1.4s, v8.4s, v10.4s
   trn2 v3.4s, v9.4s, v11.4s
   trn2 v5.4s, v12.4s, v14.4s
   trn2 v7.4s, v13.4s, v15.4s

   trn1 v8.8h, v0.8h, v2.8h
   trn1 v10.8h, v1.8h, v3.8h
   trn1 v12.8h, v4.8h, v6.8h
   trn1 v14.8h, v5.8h, v7.8h
   trn2 v9.8h, v0.8h, v2.8h
   trn2 v11.8h, v1.8h, v3.8h
   trn2 v13.8h, v4.8h, v6.8h
   trn2 v15.8h, v5.8h, v7.8h

   trn1 v0.2d, v8.2d, v12.2d
   trn1 v1.2d, v9.2d, v13.2d
   trn1 v2.2d, v10.2d, v14.2d    
   trn1 v3.2d, v11.2d, v15.2d
   trn2 v4.2d, v8.2d, v12.2d
   trn2 v5.2d, v9.2d, v13.2d
   trn2 v6.2d, v10.2d, v14.2d    
   trn2 v7.2d, v11.2d, v15.2d

   // a6a7 = a0a1+a2a3:v16-v23
   add v16.8h, v16.8h, v0.8h
   add v17.8h, v17.8h, v1.8h
   add v18.8h, v18.8h, v2.8h
   add v19.8h, v19.8h, v3.8h
   add v20.8h, v20.8h, v4.8h
   add v21.8h, v21.8h, v5.8h
   add v22.8h, v22.8h, v6.8h
   add v23.8h, v23.8h, v7.8h

   //store a6a7
   str q16, [x4, #0*16+9*128]
   str q17, [x4, #1*16+9*128]
   str q18, [x4, #2*16+9*128]
   str q19, [x4, #3*16+9*128]
   str q20, [x4, #4*16+9*128]
   str q21, [x4, #5*16+9*128]
   str q22, [x4, #6*16+9*128]
   str q23, [x4, #7*16+9*128]

   //b2b3:v16-v23
   ldr q8, [x2, #32]
   ldr q12, [x2, #48]
   ldr q9, [x3, #32]
   ldr q13, [x3, #48]
   ldr q10, [x2, #32]
   ldr q14, [x2, #48]
   ldr q11, [x3, #32]
   ldr q15, [x3, #48]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d    
   trn2 v23.2d, v11.2d, v15.2d

   //b6b7 = b2b3 + b0b1:v24-v31
   add v24.8h, v16.8h, v24.8h
   add v25.8h, v17.8h, v25.8h
   add v26.8h, v18.8h, v26.8h
   add v27.8h, v19.8h, v27.8h
   add v28.8h, v20.8h, v28.8h
   add v29.8h, v21.8h, v29.8h
   add v30.8h, v22.8h, v30.8h
   add v31.8h, v23.8h, v31.8h

   //a2b2 [0-7] * [16-23]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v0.4h,  v16.4h
   SMULL2   v15.4S,  v0.8h,  v16.8h
   SMULL    v11.4S,  v7.4h,  v23.4h
   SMULL2   v12.4S,  v7.8h,  v23.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+384]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v17.4h
   SMULL2   v15.4S,  v0.8h,  v17.8h
   SMULL    v11.4S,  v6.4h,  v23.4h
   SMULL2   v12.4S,  v6.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v16.4h
   SMLAL2   v15.4S,  v1.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v22.4h
   SMLAL2   v12.4S,  v7.8h,  v22.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+384]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v18.4h
   SMULL2   v15.4S,  v0.8h,  v18.8h
   SMULL    v11.4S,  v5.4h,  v23.4h
   SMULL2   v12.4S,  v5.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v17.4h
   SMLAL2   v15.4S,  v1.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v22.4h
   SMLAL2   v12.4S,  v6.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v16.4h
   SMLAL2   v15.4S,  v2.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v21.4h
   SMLAL2   v12.4S,  v7.8h,  v21.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+384]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v19.4h
   SMULL2   v15.4S,  v0.8h,  v19.8h
   SMULL    v11.4S,  v4.4h,  v23.4h
   SMULL2   v12.4S,  v4.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v18.4h
   SMLAL2   v15.4S,  v1.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v22.4h
   SMLAL2   v12.4S,  v5.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v17.4h
   SMLAL2   v15.4S,  v2.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v21.4h
   SMLAL2   v12.4S,  v6.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v16.4h
   SMLAL2   v15.4S,  v3.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v20.4h
   SMLAL2   v12.4S,  v7.8h,  v20.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+384]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v20.4h
   SMULL2   v15.4S,  v0.8h,  v20.8h
   SMULL    v11.4S,  v3.4h,  v23.4h
   SMULL2   v12.4S,  v3.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v19.4h
   SMLAL2   v15.4S,  v1.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v22.4h
   SMLAL2   v12.4S,  v4.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v18.4h
   SMLAL2   v15.4S,  v2.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v21.4h
   SMLAL2   v12.4S,  v5.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v17.4h
   SMLAL2   v15.4S,  v3.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v20.4h
   SMLAL2   v12.4S,  v6.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v16.4h
   SMLAL2   v15.4S,  v4.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v19.4h
   SMLAL2   v12.4S,  v7.8h,  v19.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+384]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v21.4h
   SMULL2   v15.4S,  v0.8h,  v21.8h
   SMULL    v11.4S,  v2.4h,  v23.4h
   SMULL2   v12.4S,  v2.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v20.4h
   SMLAL2   v15.4S,  v1.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v22.4h
   SMLAL2   v12.4S,  v3.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v19.4h
   SMLAL2   v15.4S,  v2.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v21.4h
   SMLAL2   v12.4S,  v4.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v18.4h
   SMLAL2   v15.4S,  v3.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v20.4h
   SMLAL2   v12.4S,  v5.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v17.4h
   SMLAL2   v15.4S,  v4.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v19.4h
   SMLAL2   v12.4S,  v6.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v16.4h
   SMLAL2   v15.4S,  v5.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v18.4h
   SMLAL2   v12.4S,  v7.8h,  v18.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+384]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v22.4h
   SMULL2   v15.4S,  v0.8h,  v22.8h
   SMULL    v11.4S,  v1.4h,  v23.4h
   SMULL2   v12.4S,  v1.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v21.4h
   SMLAL2   v15.4S,  v1.8h,  v21.8h
   SMLAL    v11.4S,  v2.4h,  v22.4h
   SMLAL2   v12.4S,  v2.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v20.4h
   SMLAL2   v15.4S,  v2.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v21.4h
   SMLAL2   v12.4S,  v3.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v19.4h
   SMLAL2   v15.4S,  v3.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v20.4h
   SMLAL2   v12.4S,  v4.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v18.4h
   SMLAL2   v15.4S,  v4.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v19.4h
   SMLAL2   v12.4S,  v5.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v17.4h
   SMLAL2   v15.4S,  v5.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v18.4h
   SMLAL2   v12.4S,  v6.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v16.4h
   SMLAL2   v15.4S,  v6.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v17.4h
   SMLAL2   v12.4S,  v7.8h,  v17.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+384]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v23.4h
   SMULL2    v15.4S,  v0.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v22.4h
   SMLAL2    v15.4S,  v1.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v21.4h
   SMLAL2    v15.4S,  v2.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v20.4h
   SMLAL2    v15.4S,  v3.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v19.4h
   SMLAL2    v15.4S,  v4.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v18.4h
   SMLAL2    v15.4S,  v5.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v17.4h
   SMLAL2    v15.4S,  v6.8h,  v17.8h
   SMLAL    v14.4S,  v7.4h,  v16.4h
   SMLAL2    v15.4S,  v7.8h,  v16.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+384]

   //store a2a3
   str q0, [x4, #0*16+10*128]
   str q1, [x4, #1*16+10*128]
   str q2, [x4, #2*16+10*128]
   str q3, [x4, #3*16+10*128]
   str q4, [x4, #4*16+10*128]
   str q5, [x4, #5*16+10*128]
   str q6, [x4, #6*16+10*128]
   str q7, [x4, #7*16+10*128]

   //load a6a7: v0-v7
   ldr q0, [x4, #0*16+9*128]
   ldr q1, [x4, #1*16+9*128]
   ldr q2, [x4, #2*16+9*128]
   ldr q3, [x4, #3*16+9*128]
   ldr q4, [x4, #4*16+9*128]
   ldr q5, [x4, #5*16+9*128]
   ldr q6, [x4, #6*16+9*128]
   ldr q7, [x4, #7*16+9*128]

   // a6b6 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+896]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+896]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+896]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+896]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+896]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+896]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+896]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+896]

   //b0b1 = b6b7 - b2b3:v8-v15
   SUB v8.8h, v24.8h, v16.8h
   SUB v9.8h, v25.8h, v17.8h
   SUB v10.8h, v26.8h, v18.8h
   SUB v11.8h, v27.8h, v19.8h
   SUB v12.8h, v28.8h, v20.8h
   SUB v13.8h, v29.8h, v21.8h
   SUB v14.8h, v30.8h, v22.8h
   SUB v15.8h, v31.8h, v23.8h

   //transpose
   //b0b2: v24-v31
   trn1 v24.2d, v8.2d, v16.2d
   trn1 v25.2d, v9.2d, v17.2d
   trn1 v26.2d, v10.2d, v18.2d    
   trn1 v27.2d, v11.2d, v19.2d
   trn1 v28.2d, v12.2d, v20.2d
   trn1 v29.2d, v13.2d, v21.2d
   trn1 v30.2d, v14.2d, v22.2d    
   trn1 v31.2d, v15.2d, v23.2d

   //b1b3: v16-v23
   trn2 v16.2d, v8.2d, v16.2d
   trn2 v17.2d, v9.2d, v17.2d
   trn2 v18.2d, v10.2d, v18.2d    
   trn2 v19.2d, v11.2d, v19.2d
   trn2 v20.2d, v12.2d, v20.2d
   trn2 v21.2d, v13.2d, v21.2d
   trn2 v22.2d, v14.2d, v22.2d    
   trn2 v23.2d, v15.2d, v23.2d

   //b4b5: v24-v31
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h

   //load a2a3: v16-v23
   ldr q16, [x4, #0*16+10*128]
   ldr q17, [x4, #1*16+10*128]
   ldr q18, [x4, #2*16+10*128]
   ldr q19, [x4, #3*16+10*128]
   ldr q20, [x4, #4*16+10*128]
   ldr q21, [x4, #5*16+10*128]
   ldr q22, [x4, #6*16+10*128]
   ldr q23, [x4, #7*16+10*128]


   //a0a1 = a6a7 - a2a3:v0-v8
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h
   SUB v4.8h, v4.8h, v20.8h
   SUB v5.8h, v5.8h, v21.8h
   SUB v6.8h, v6.8h, v22.8h
   SUB v7.8h, v7.8h, v23.8h

   //transpose
   // a0a2: v8-v15
   trn1 v8.2d, v0.2d, v16.2d
   trn1 v9.2d, v1.2d, v17.2d
   trn1 v10.2d, v2.2d, v18.2d
   trn1 v11.2d, v3.2d, v19.2d
   trn1 v12.2d, v4.2d, v20.2d
   trn1 v13.2d, v5.2d, v21.2d
   trn1 v14.2d, v6.2d, v22.2d
   trn1 v15.2d, v7.2d, v23.2d

   // a1a3: v0-v7
   trn2 v0.2d, v0.2d, v16.2d
   trn2 v1.2d, v1.2d, v17.2d
   trn2 v2.2d, v2.2d, v18.2d
   trn2 v3.2d, v3.2d, v19.2d
   trn2 v4.2d, v4.2d, v20.2d
   trn2 v5.2d, v5.2d, v21.2d
   trn2 v6.2d, v6.2d, v22.2d
   trn2 v7.2d, v7.2d, v23.2d

   // a4a5: v0-v7
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   ADD v4.8h, v4.8h, v12.8h
   ADD v5.8h, v5.8h, v13.8h
   ADD v6.8h, v6.8h, v14.8h
   ADD v7.8h, v7.8h, v15.8h

   //load t
   mov      w5,  #4591
   DUP      v9.8H,  w5
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //a4b4 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+640]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+640]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+640]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+640]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+640]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+640]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+640]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+640]


   mov      w8, #7
   DUP      v8.8H,  w8
   // mov a5 and b5
   MOV d16, v0.2d[1]
   // a8: v0-v7 & barrett
   ADD v0.4h, v0.4h, v16.4h
   SQRDMULH v14.4h, v0.4h, v8.4h
   MOV d16, v24.2d[1]
   MOV d17, v1.2d[1]
   MLS      v0.4h, v14.4h, v9.4h
   ADD v24.4h, v24.4h, v16.4h
   ADD v1.4h, v1.4h, v17.4h
   SQRDMULH v14.4h, v1.4h, v8.4h
   MOV d17, v25.2d[1]
   MOV d18, v2.2d[1]
   MLS      v1.4h, v14.4h, v9.4h
   ADD v25.4h, v25.4h, v17.4h
   ADD v2.4h, v2.4h, v18.4h
   SQRDMULH v14.4h, v2.4h, v8.4h
   MOV d18, v26.2d[1]
   MOV d19, v3.2d[1]
   MLS      v2.4h, v14.4h, v9.4h
   ADD v26.4h, v26.4h, v18.4h
   ADD v3.4h, v3.4h, v19.4h
   SQRDMULH v14.4h, v3.4h, v8.4h
   MOV d19, v27.2d[1]
   MOV d20, v4.2d[1]
   MLS      v3.4h, v14.4h, v9.4h
   ADD v27.4h, v27.4h, v19.4h
   ADD v4.4h, v4.4h, v20.4h
   SQRDMULH v14.4h, v4.4h, v8.4h
   MOV d20, v28.2d[1]
   MOV d21, v5.2d[1]
   MLS      v4.4h, v14.4h, v9.4h
   ADD v28.4h, v28.4h, v20.4h
   ADD v5.4h, v5.4h, v21.4h
   SQRDMULH v14.4h, v5.4h, v8.4h
   MOV d21, v29.2d[1]
   MOV d22, v6.2d[1]
   MLS      v5.4h, v14.4h, v9.4h
   ADD v29.4h, v29.4h, v21.4h
   ADD v6.4h, v6.4h, v22.4h
   SQRDMULH v14.4h, v6.4h, v8.4h
   MOV d22, v30.2d[1]
   MOV d23, v7.2d[1]
   MLS      v6.4h, v14.4h, v9.4h
   ADD v30.4h, v30.4h, v22.4h
   ADD v7.4h, v7.4h, v23.4h
   SQRDMULH v14.4h, v7.4h, v8.4h
   MOV d23, v31.2d[1]
   MLS      v7.4h, v14.4h, v9.4h
   ADD v31.4h, v31.4h, v23.4h

   // b8: v24-v31
   SQRDMULH v14.4h, v24.4h, v8.4h
   MLS      v24.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v25.4h, v8.4h
   MLS      v25.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v26.4h, v8.4h
   MLS      v26.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v27.4h, v8.4h
   MLS      v27.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v28.4h, v8.4h
   MLS      v28.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v29.4h, v8.4h
   MLS      v29.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v30.4h, v8.4h
   MLS      v30.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v31.4h, v8.4h
   MLS      v31.4h, v14.4h, v9.4h

   // a8b8 [0-7] * [24-31]
   //;c[0]&c[14]
   SMULL    v14.4S,  v24.4h,  v0.4h
   SMULL    v15.4S,  v31.4h,  v7.4h
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #0*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #14*8+1024]

   //;c[1]&c[13]
   SMULL    v14.4S,  v24.4h,  v1.4h
   SMULL    v15.4S,  v30.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v6.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #1*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #13*8+1024]

   //;c[2]&c[12]
   SMULL    v14.4S,  v24.4h,  v2.4h
   SMULL    v15.4S,  v29.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v5.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #2*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #12*8+1024]

   //;c[3]&c[11]
   SMULL    v14.4S,  v24.4h,  v3.4h
   SMULL    v15.4S,  v28.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v4.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #3*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #11*8+1024]

   //;c[4]&c[10]
   SMULL    v14.4S,  v24.4h,  v4.4h
   SMULL    v15.4S,  v27.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v3.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #4*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #10*8+1024]

   //;c[5]&c[9]
   SMULL    v14.4S,  v24.4h,  v5.4h
   SMULL    v15.4S,  v26.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v2.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #5*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #9*8+1024]

   //;c[6]&c[8]
   SMULL    v14.4S,  v24.4h,  v6.4h
   SMULL    v15.4S,  v25.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v5.4h
   SMLAL    v15.4S,  v26.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v1.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #6*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #8*8+1024]

   //;c[7]
   SMULL    v14.4S,  v24.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v1.4h
   SMLAL    v14.4S,  v31.4h,  v0.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v10.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v10.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+1024]


   //Butterfly & itranspose
   //[16-23] = arg0 = mc[1][i+4] + mc[2][i];
   //load mc[1][i+4]
   ldr q16, [x4, #0*16+64*3]
   ldr q17, [x4, #1*16+64*3]
   ldr q18, [x4, #2*16+64*3]
   ldr q19, [x4, #3*16+64*3]
   //load mc[2][i]
   ldr q8, [x4, #0*16+64*4]
   ldr q9, [x4, #1*16+64*4]
   ldr q10, [x4, #2*16+64*4]
   ldr q11, [x4, #3*16+64*4]
   ADD v16.8h, v16.8h, v8.8h
   ADD v17.8h, v17.8h, v9.8h
   ADD v18.8h, v18.8h, v10.8h
   ADD v19.8h, v19.8h, v11.8h

   //[24-31] = arg3 = mc[2][i+4] - mc[3][i];
   //load mc[2][i+8]
   ldr q24, [x4, #0*16+64*5]
   ldr q25, [x4, #1*16+64*5]
   ldr q26, [x4, #2*16+64*5]
   ldr q27, [x4, #3*16+64*5]
   //load mc[3][i]
   ldr q8, [x4, #0*16+64*6]
   ldr q9, [x4, #1*16+64*6]
   ldr q10, [x4, #2*16+64*6]
   ldr q11, [x4, #3*16+64*6]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i] = mc[5][i+4] - arg3
   //load mc[5][i+8]
   ldr q0, [x4, #0*16+64*11]
   ldr q1, [x4, #1*16+64*11]
   ldr q2, [x4, #2*16+64*11]
   ldr q3, [x4, #3*16+64*11]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h

   //[24-31] = arg4 = arg3 + mc[5][i] - arg0
   //load  mc[5][i]
   ldr q8, [x4, #0*16+64*10]
   ldr q9, [x4, #1*16+64*10]
   ldr q10, [x4, #2*16+64*10]
   ldr q11, [x4, #3*16+64*10]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   SUB v24.8h, v24.8h, v16.8h
   SUB v25.8h, v25.8h, v17.8h
   SUB v26.8h, v26.8h, v18.8h
   SUB v27.8h, v27.8h, v19.8h

   //store arg0 in mc[1][i+8] [16-23]
   str q16, [x4, #0*16+64*3]
   str q17, [x4, #1*16+64*3]
   str q18, [x4, #2*16+64*3]
   str q19, [x4, #3*16+64*3]

   //store arg4 in mc[2][i]   [24-31]
   str q24, [x4, #0*16+64*4]
   str q25, [x4, #1*16+64*4]
   str q26, [x4, #2*16+64*4]
   str q27, [x4, #3*16+64*4]

   //[24-31] out[2][i+4] = arg4 - mc[3][i+4];
   //load  mc[3][i+4]
   ldr q8, [x4, #0*16+64*7]
   ldr q9, [x4, #1*16+64*7]
   ldr q10, [x4, #2*16+64*7]
   ldr q11, [x4, #3*16+64*7]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i]   = mc[5][i+8] - arg3 - mc[3][i+4];
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h

   //itranspose & store out[3][i+4] = mc[3][i+4]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   //barrett
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h
   str q12, [x0, #0*128+7*16]
   str q13, [x0, #1*128+7*16]

   //out[2][i+4] = barrett_fake(arg4 - mc[3][i+4] + mc[7][i+4]);
   //load  mc[7][i+4]
   ldr q8, [x4, #0*16+64*15]
   ldr q9, [x4, #1*16+64*15]
   ldr q10, [x4, #2*16+64*15]
   ldr q11, [x4, #3*16+64*15]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[2][i+4]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+5*16]
   str q29, [x0, #1*128+5*16]


   //[0-7]  = out[3][i]
   //barrett
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //out[2][i] = mc[8][i+4] - (mc[7][i+4] +  out[3][i])
   ADD v8.8h, v8.8h, v0.8h
   ADD v9.8h, v9.8h, v1.8h
   ADD v10.8h, v10.8h, v2.8h
   ADD v11.8h, v11.8h, v3.8h
   //load mc[8][i+8]
   ldr q16, [x4, #0*16+64*17]
   ldr q17, [x4, #1*16+64*17]
   ldr q18, [x4, #2*16+64*17]
   ldr q19, [x4, #3*16+64*17]
   SUB v8.8h, v16.8h, v8.8h
   SUB v9.8h, v17.8h, v9.8h
   SUB v10.8h, v18.8h, v10.8h
   SUB v11.8h, v19.8h, v11.8h

   //itranspose & store out[3][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+6*16]
   str q5, [x0, #1*128+6*16]


   //[8-15] = out[2][i]
   //[24-31]  = arg1
   //arg1 = mc[1][i] - mc[0][i+8]
   //load mc[1][i]
   ldr q24, [x4, #0*16+64*2]
   ldr q25, [x4, #1*16+64*2]
   ldr q26, [x4, #2*16+64*2]
   ldr q27, [x4, #3*16+64*2]
   //load mc[0][i+8]
   ldr q0, [x4, #0*16+64*1]
   ldr q1, [x4, #1*16+64*1]
   ldr q2, [x4, #2*16+64*1]
   ldr q3, [x4, #3*16+64*1]
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h

   //[0-7] = arg0 => arg2 = arg1 - arg0 +  mc[4][i+8]
   //load arg0
   ldr q0, [x4, #0*16+64*3]
   ldr q1, [x4, #1*16+64*3]
   ldr q2, [x4, #2*16+64*3]
   ldr q3, [x4, #3*16+64*3]
   SUB v0.8h, v24.8h, v0.8h
   SUB v1.8h, v25.8h, v1.8h
   SUB v2.8h, v26.8h, v2.8h
   SUB v3.8h, v27.8h, v3.8h
   //load mc[4][i+8] 
   ldr q16, [x4, #0*16+64*9]
   ldr q17, [x4, #1*16+64*9]
   ldr q18, [x4, #2*16+64*9]
   ldr q19, [x4, #3*16+64*9]
   ADD v0.8h, v0.8h, v16.8h
   ADD v1.8h, v1.8h, v17.8h
   ADD v2.8h, v2.8h, v18.8h
   ADD v3.8h, v3.8h, v19.8h

   //[0-7] = arg2
   //[8-15] = out[2][i] - arg2
   SUB v8.8h, v8.8h, v0.8h
   SUB v9.8h, v9.8h, v1.8h
   SUB v10.8h, v10.8h, v2.8h
   SUB v11.8h, v11.8h, v3.8h
   //store out[2][i] - arg2 
   str q8, [x4, #0*16+64*3]
   str q9, [x4, #1*16+64*3]
   str q10, [x4, #2*16+64*3]
   str q11, [x4, #3*16+64*3]

   //[8-15] = mc[0][i];
   //load mc[0][i]
   ldr q8, [x4, #0*16]
   ldr q9, [x4, #1*16]
   ldr q10, [x4, #2*16]
   ldr q11, [x4, #3*16]

   //[0-7] = arg2 - mc[0][i]
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   //[24-31] = arg1 + mc[0][i]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[0][i] = mc[0][i]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h
   str q12, [x0, #0*128+0*16]
   str q13, [x0, #1*128+0*16]

   //[24-31] = arg1 + mc[0][i]; [0-7] = arg2 - mc[0][i]
   //out[0][i+4] = barrett_fake(mc[4][i]   - (mc[0][i]   +  arg1));
   //load mc[4][i]
   ldr q8, [x4, #0*16+64*8]
   ldr q9, [x4, #1*16+64*8]
   ldr q10, [x4, #2*16+64*8]
   ldr q11, [x4, #3*16+64*8]
   //out[0][i+8]
   SUB v24.8h, v8.8h, v24.8h
   SUB v25.8h, v9.8h, v25.8h
   SUB v26.8h, v10.8h, v26.8h
   SUB v27.8h, v11.8h, v27.8h

   //barrett out[0][i+8]
   //;v18, v19 = 7, 4591
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h

   //[0-7] = out[1][i] = arg2 - mc[0][i] + mc[6][i]
   //load  [8-15] mc[6][i]
   ldr q8, [x4, #0*16+64*12]
   ldr q9, [x4, #1*16+64*12]
   ldr q10, [x4, #2*16+64*12]
   ldr q11, [x4, #3*16+64*12]
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   //[8-15] mc[6][i] + out[0][i+8]
   ADD v8.8h, v8.8h, v24.8h
   ADD v9.8h, v9.8h, v25.8h
   ADD v10.8h, v10.8h, v26.8h
   ADD v11.8h, v11.8h, v27.8h

   //itranspose & store out[0][i+8]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+1*16]
   str q29, [x0, #1*128+1*16]

   //[0-7]barrett_fake(out[1][i])
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+2*16]
   str q5, [x0, #1*128+2*16]

   //[8-15] mc[6][i] + out[0][i+4]
   //[0-7] arg5 = mc[6][i+4] - mc[7][i];
   //load mc[6][i+4]
   ldr q0, [x4, #0*16+64*13]
   ldr q1, [x4, #1*16+64*13]
   ldr q2, [x4, #2*16+64*13]
   ldr q3, [x4, #3*16+64*13]
   //load mc[7][i]
   ldr q16, [x4, #0*16+64*14]
   ldr q17, [x4, #1*16+64*14]
   ldr q18, [x4, #2*16+64*14]
   ldr q19, [x4, #3*16+64*14]
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h


   //[24-31] =  out[2][i] - arg2
   //load out[2][i] - arg2 
   ldr q24, [x4, #0*16+64*3]
   ldr q25, [x4, #1*16+64*3]
   ldr q26, [x4, #2*16+64*3]
   ldr q27, [x4, #3*16+64*3]
   //out[2][i] - arg2 - arg5
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h
   //barrett out[2][i]
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h
   
   //itranspose & store out[2][i]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+4*16]
   str q29, [x0, #1*128+4*16]

   //[8-15] mc[6][i] + out[0][i+4]; [0-7] = arg5
   //out[1][i+4] = barrett_fake(arg5 + mc[8][i]   - (arg4 + mc[6][i] + out[0][i+4]));
   //load mc[8][i] 
   ldr q24, [x4, #0*16+64*16]
   ldr q25, [x4, #1*16+64*16]
   ldr q26, [x4, #2*16+64*16]
   ldr q27, [x4, #3*16+64*16]
   ADD v0.8h, v0.8h, v24.8h
   ADD v1.8h, v1.8h, v25.8h
   ADD v2.8h, v2.8h, v26.8h
   ADD v3.8h, v3.8h, v27.8h
   //load arg4
   ldr q24, [x4, #0*16+64*4]
   ldr q25, [x4, #1*16+64*4]
   ldr q26, [x4, #2*16+64*4]
   ldr q27, [x4, #3*16+64*4]
   //(arg4 + mc[6][i] + out[0][i+8])
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   //out[1][i+8]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h


   //barrett out[1][i+8]
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i+8]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+3*16]
   str q5, [x0, #1*128+3*16]

   ret


__asm_4x32x32_x1:
___asm_4x32x32_x1:
   mov      w5,  #0
   DUP      v0.8h,  w5
   str q0, [x0, #0*128+0*16] 
   str q0, [x4, #112+0*128]
   str q0, [x4, #112+1*128]
   str q0, [x4, #112+2*128]
   str q0, [x4, #112+3*128]
   str q0, [x4, #112+4*128]
   str q0, [x4, #112+5*128]
   str q0, [x4, #112+6*128]
   str q0, [x4, #112+7*128]
   str q0, [x4, #112+8*128]
   str q0, [x4, #112+9*128]
   str q0, [x4, #112+10*128]

   //a0a1:v16-v23
   ldr q8, [x1, #0*64]
   ldr q12, [x1, #0*64+16]
   ldr q9, [x1, #1*64]
   ldr q13, [x1, #1*64+16]
   ldr q10, [x1, #2*64]
   ldr q14, [x1, #2*64+16]
   ldr q11, [x1, #3*64]
   ldr q15, [x1, #3*64+16]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d


   //b0b1:v24-v31
   ldr q8, [x2, #0]
   ldr q12, [x2, #16]
   ldr q9, [x3, #0]
   ldr q13, [x3, #16]
   ldr q10, [x2, #0]
   ldr q14, [x2, #16]
   ldr q11, [x3, #0]
   ldr q15, [x3, #16]

   trn1 v24.4s, v8.4s, v10.4s
   trn1 v26.4s, v9.4s, v11.4s
   trn1 v28.4s, v12.4s, v14.4s
   trn1 v30.4s, v13.4s, v15.4s
   trn2 v25.4s, v8.4s, v10.4s
   trn2 v27.4s, v9.4s, v11.4s
   trn2 v29.4s, v12.4s, v14.4s
   trn2 v31.4s, v13.4s, v15.4s

   trn1 v8.8h, v24.8h, v26.8h
   trn1 v10.8h, v25.8h, v27.8h
   trn1 v12.8h, v28.8h, v30.8h
   trn1 v14.8h, v29.8h, v31.8h
   trn2 v9.8h, v24.8h, v26.8h
   trn2 v11.8h, v25.8h, v27.8h
   trn2 v13.8h, v28.8h, v30.8h
   trn2 v15.8h, v29.8h, v31.8h

   trn1 v24.2d, v8.2d, v12.2d
   trn1 v25.2d, v9.2d, v13.2d
   trn1 v26.2d, v10.2d, v14.2d    
   trn1 v27.2d, v11.2d, v15.2d
   trn2 v28.2d, v8.2d, v12.2d
   trn2 v29.2d, v9.2d, v13.2d
   trn2 v30.2d, v10.2d, v14.2d    
   trn2 v31.2d, v11.2d, v15.2d

   //a0b0 [16-23] * [24-31]
   //;c[0]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+128]
   //;c[1]
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
   STR      d13,     [x4, #1*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+128]
   //;c[2]
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
   STR      d13,     [x4, #2*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+128]
   //;c[3]
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
   STR      d13,     [x4, #3*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+128]
   //;c[4]
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
   STR      d13,     [x4, #4*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+128]
   //;c[5]
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
   STR      d13,     [x4, #5*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+128]
   //;c[6]
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
   STR      d13,     [x4, #6*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+128]


   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2    v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2    v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2    v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2    v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2    v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2    v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2    v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2    v15.4S,  v23.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+128]
   

   //a2a3:v0-v7
   ldr q8, [x1, #0*64+32]
   ldr q12, [x1, #0*64+48]
   ldr q9, [x1, #1*64+32]
   ldr q13, [x1, #1*64+48]
   ldr q10, [x1, #2*64+32]
   ldr q14, [x1, #2*64+48]
   ldr q11, [x1, #3*64+32]
   ldr q15, [x1, #3*64+48]

   trn1 v0.4s, v8.4s, v10.4s
   trn1 v2.4s, v9.4s, v11.4s
   trn1 v4.4s, v12.4s, v14.4s
   trn1 v6.4s, v13.4s, v15.4s
   trn2 v1.4s, v8.4s, v10.4s
   trn2 v3.4s, v9.4s, v11.4s
   trn2 v5.4s, v12.4s, v14.4s
   trn2 v7.4s, v13.4s, v15.4s

   trn1 v8.8h, v0.8h, v2.8h
   trn1 v10.8h, v1.8h, v3.8h
   trn1 v12.8h, v4.8h, v6.8h
   trn1 v14.8h, v5.8h, v7.8h
   trn2 v9.8h, v0.8h, v2.8h
   trn2 v11.8h, v1.8h, v3.8h
   trn2 v13.8h, v4.8h, v6.8h
   trn2 v15.8h, v5.8h, v7.8h

   trn1 v0.2d, v8.2d, v12.2d
   trn1 v1.2d, v9.2d, v13.2d
   trn1 v2.2d, v10.2d, v14.2d    
   trn1 v3.2d, v11.2d, v15.2d
   trn2 v4.2d, v8.2d, v12.2d
   trn2 v5.2d, v9.2d, v13.2d
   trn2 v6.2d, v10.2d, v14.2d    
   trn2 v7.2d, v11.2d, v15.2d

   // a6a7 = a0a1+a2a3:v16-v23
   add v16.8h, v16.8h, v0.8h
   add v17.8h, v17.8h, v1.8h
   add v18.8h, v18.8h, v2.8h
   add v19.8h, v19.8h, v3.8h
   add v20.8h, v20.8h, v4.8h
   add v21.8h, v21.8h, v5.8h
   add v22.8h, v22.8h, v6.8h
   add v23.8h, v23.8h, v7.8h

   //store a6a7
   str q16, [x4, #0*16+9*128]
   str q17, [x4, #1*16+9*128]
   str q18, [x4, #2*16+9*128]
   str q19, [x4, #3*16+9*128]
   str q20, [x4, #4*16+9*128]
   str q21, [x4, #5*16+9*128]
   str q22, [x4, #6*16+9*128]
   str q23, [x4, #7*16+9*128]

   //b2b3:v16-v23
   ldr q8, [x2, #32]
   ldr q12, [x2, #48]
   ldr q9, [x3, #32]
   ldr q13, [x3, #48]
   ldr q10, [x2, #32]
   ldr q14, [x2, #48]
   ldr q11, [x3, #32]
   ldr q15, [x3, #48]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d    
   trn2 v23.2d, v11.2d, v15.2d

   //b6b7 = b2b3 + b0b1:v24-v31
   add v24.8h, v16.8h, v24.8h
   add v25.8h, v17.8h, v25.8h
   add v26.8h, v18.8h, v26.8h
   add v27.8h, v19.8h, v27.8h
   add v28.8h, v20.8h, v28.8h
   add v29.8h, v21.8h, v29.8h
   add v30.8h, v22.8h, v30.8h
   add v31.8h, v23.8h, v31.8h

   //a2b2 [0-7] * [16-23]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v0.4h,  v16.4h
   SMULL2   v15.4S,  v0.8h,  v16.8h
   SMULL    v11.4S,  v7.4h,  v23.4h
   SMULL2   v12.4S,  v7.8h,  v23.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+384]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v17.4h
   SMULL2   v15.4S,  v0.8h,  v17.8h
   SMULL    v11.4S,  v6.4h,  v23.4h
   SMULL2   v12.4S,  v6.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v16.4h
   SMLAL2   v15.4S,  v1.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v22.4h
   SMLAL2   v12.4S,  v7.8h,  v22.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+384]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v18.4h
   SMULL2   v15.4S,  v0.8h,  v18.8h
   SMULL    v11.4S,  v5.4h,  v23.4h
   SMULL2   v12.4S,  v5.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v17.4h
   SMLAL2   v15.4S,  v1.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v22.4h
   SMLAL2   v12.4S,  v6.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v16.4h
   SMLAL2   v15.4S,  v2.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v21.4h
   SMLAL2   v12.4S,  v7.8h,  v21.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+384]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v19.4h
   SMULL2   v15.4S,  v0.8h,  v19.8h
   SMULL    v11.4S,  v4.4h,  v23.4h
   SMULL2   v12.4S,  v4.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v18.4h
   SMLAL2   v15.4S,  v1.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v22.4h
   SMLAL2   v12.4S,  v5.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v17.4h
   SMLAL2   v15.4S,  v2.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v21.4h
   SMLAL2   v12.4S,  v6.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v16.4h
   SMLAL2   v15.4S,  v3.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v20.4h
   SMLAL2   v12.4S,  v7.8h,  v20.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+384]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v20.4h
   SMULL2   v15.4S,  v0.8h,  v20.8h
   SMULL    v11.4S,  v3.4h,  v23.4h
   SMULL2   v12.4S,  v3.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v19.4h
   SMLAL2   v15.4S,  v1.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v22.4h
   SMLAL2   v12.4S,  v4.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v18.4h
   SMLAL2   v15.4S,  v2.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v21.4h
   SMLAL2   v12.4S,  v5.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v17.4h
   SMLAL2   v15.4S,  v3.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v20.4h
   SMLAL2   v12.4S,  v6.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v16.4h
   SMLAL2   v15.4S,  v4.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v19.4h
   SMLAL2   v12.4S,  v7.8h,  v19.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+384]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v21.4h
   SMULL2   v15.4S,  v0.8h,  v21.8h
   SMULL    v11.4S,  v2.4h,  v23.4h
   SMULL2   v12.4S,  v2.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v20.4h
   SMLAL2   v15.4S,  v1.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v22.4h
   SMLAL2   v12.4S,  v3.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v19.4h
   SMLAL2   v15.4S,  v2.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v21.4h
   SMLAL2   v12.4S,  v4.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v18.4h
   SMLAL2   v15.4S,  v3.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v20.4h
   SMLAL2   v12.4S,  v5.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v17.4h
   SMLAL2   v15.4S,  v4.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v19.4h
   SMLAL2   v12.4S,  v6.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v16.4h
   SMLAL2   v15.4S,  v5.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v18.4h
   SMLAL2   v12.4S,  v7.8h,  v18.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+384]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v22.4h
   SMULL2   v15.4S,  v0.8h,  v22.8h
   SMULL    v11.4S,  v1.4h,  v23.4h
   SMULL2   v12.4S,  v1.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v21.4h
   SMLAL2   v15.4S,  v1.8h,  v21.8h
   SMLAL    v11.4S,  v2.4h,  v22.4h
   SMLAL2   v12.4S,  v2.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v20.4h
   SMLAL2   v15.4S,  v2.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v21.4h
   SMLAL2   v12.4S,  v3.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v19.4h
   SMLAL2   v15.4S,  v3.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v20.4h
   SMLAL2   v12.4S,  v4.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v18.4h
   SMLAL2   v15.4S,  v4.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v19.4h
   SMLAL2   v12.4S,  v5.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v17.4h
   SMLAL2   v15.4S,  v5.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v18.4h
   SMLAL2   v12.4S,  v6.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v16.4h
   SMLAL2   v15.4S,  v6.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v17.4h
   SMLAL2   v12.4S,  v7.8h,  v17.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+384]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v23.4h
   SMULL2    v15.4S,  v0.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v22.4h
   SMLAL2    v15.4S,  v1.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v21.4h
   SMLAL2    v15.4S,  v2.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v20.4h
   SMLAL2    v15.4S,  v3.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v19.4h
   SMLAL2    v15.4S,  v4.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v18.4h
   SMLAL2    v15.4S,  v5.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v17.4h
   SMLAL2    v15.4S,  v6.8h,  v17.8h
   SMLAL    v14.4S,  v7.4h,  v16.4h
   SMLAL2    v15.4S,  v7.8h,  v16.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+384]

   //store a2a3
   str q0, [x4, #0*16+10*128]
   str q1, [x4, #1*16+10*128]
   str q2, [x4, #2*16+10*128]
   str q3, [x4, #3*16+10*128]
   str q4, [x4, #4*16+10*128]
   str q5, [x4, #5*16+10*128]
   str q6, [x4, #6*16+10*128]
   str q7, [x4, #7*16+10*128]

   //load a6a7: v0-v7
   ldr q0, [x4, #0*16+9*128]
   ldr q1, [x4, #1*16+9*128]
   ldr q2, [x4, #2*16+9*128]
   ldr q3, [x4, #3*16+9*128]
   ldr q4, [x4, #4*16+9*128]
   ldr q5, [x4, #5*16+9*128]
   ldr q6, [x4, #6*16+9*128]
   ldr q7, [x4, #7*16+9*128]

   // a6b6 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+896]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+896]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+896]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+896]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+896]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+896]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+896]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+896]

   //b0b1 = b6b7 - b2b3:v8-v15
   SUB v8.8h, v24.8h, v16.8h
   SUB v9.8h, v25.8h, v17.8h
   SUB v10.8h, v26.8h, v18.8h
   SUB v11.8h, v27.8h, v19.8h
   SUB v12.8h, v28.8h, v20.8h
   SUB v13.8h, v29.8h, v21.8h
   SUB v14.8h, v30.8h, v22.8h
   SUB v15.8h, v31.8h, v23.8h

   //transpose
   //b0b2: v24-v31
   trn1 v24.2d, v8.2d, v16.2d
   trn1 v25.2d, v9.2d, v17.2d
   trn1 v26.2d, v10.2d, v18.2d    
   trn1 v27.2d, v11.2d, v19.2d
   trn1 v28.2d, v12.2d, v20.2d
   trn1 v29.2d, v13.2d, v21.2d
   trn1 v30.2d, v14.2d, v22.2d    
   trn1 v31.2d, v15.2d, v23.2d

   //b1b3: v16-v23
   trn2 v16.2d, v8.2d, v16.2d
   trn2 v17.2d, v9.2d, v17.2d
   trn2 v18.2d, v10.2d, v18.2d    
   trn2 v19.2d, v11.2d, v19.2d
   trn2 v20.2d, v12.2d, v20.2d
   trn2 v21.2d, v13.2d, v21.2d
   trn2 v22.2d, v14.2d, v22.2d    
   trn2 v23.2d, v15.2d, v23.2d

   //b4b5: v24-v31
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h

   //load a2a3: v16-v23
   ldr q16, [x4, #0*16+10*128]
   ldr q17, [x4, #1*16+10*128]
   ldr q18, [x4, #2*16+10*128]
   ldr q19, [x4, #3*16+10*128]
   ldr q20, [x4, #4*16+10*128]
   ldr q21, [x4, #5*16+10*128]
   ldr q22, [x4, #6*16+10*128]
   ldr q23, [x4, #7*16+10*128]


   //a0a1 = a6a7 - a2a3:v0-v8
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h
   SUB v4.8h, v4.8h, v20.8h
   SUB v5.8h, v5.8h, v21.8h
   SUB v6.8h, v6.8h, v22.8h
   SUB v7.8h, v7.8h, v23.8h

   //transpose
   // a0a2: v8-v15
   trn1 v8.2d, v0.2d, v16.2d
   trn1 v9.2d, v1.2d, v17.2d
   trn1 v10.2d, v2.2d, v18.2d
   trn1 v11.2d, v3.2d, v19.2d
   trn1 v12.2d, v4.2d, v20.2d
   trn1 v13.2d, v5.2d, v21.2d
   trn1 v14.2d, v6.2d, v22.2d
   trn1 v15.2d, v7.2d, v23.2d

   // a1a3: v0-v7
   trn2 v0.2d, v0.2d, v16.2d
   trn2 v1.2d, v1.2d, v17.2d
   trn2 v2.2d, v2.2d, v18.2d
   trn2 v3.2d, v3.2d, v19.2d
   trn2 v4.2d, v4.2d, v20.2d
   trn2 v5.2d, v5.2d, v21.2d
   trn2 v6.2d, v6.2d, v22.2d
   trn2 v7.2d, v7.2d, v23.2d

   // a4a5: v0-v7
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   ADD v4.8h, v4.8h, v12.8h
   ADD v5.8h, v5.8h, v13.8h
   ADD v6.8h, v6.8h, v14.8h
   ADD v7.8h, v7.8h, v15.8h

   //load t
   mov      w5,  #4591
   DUP      v9.8H,  w5
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //a4b4 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+640]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+640]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+640]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+640]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+640]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+640]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+640]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+640]


   mov      w8, #7
   DUP      v8.8H,  w8
   // mov a5 and b5
   MOV d16, v0.2d[1]
   // a8: v0-v7 & barrett
   ADD v0.4h, v0.4h, v16.4h
   SQRDMULH v14.4h, v0.4h, v8.4h
   MOV d16, v24.2d[1]
   MOV d17, v1.2d[1]
   MLS      v0.4h, v14.4h, v9.4h
   ADD v24.4h, v24.4h, v16.4h
   ADD v1.4h, v1.4h, v17.4h
   SQRDMULH v14.4h, v1.4h, v8.4h
   MOV d17, v25.2d[1]
   MOV d18, v2.2d[1]
   MLS      v1.4h, v14.4h, v9.4h
   ADD v25.4h, v25.4h, v17.4h
   ADD v2.4h, v2.4h, v18.4h
   SQRDMULH v14.4h, v2.4h, v8.4h
   MOV d18, v26.2d[1]
   MOV d19, v3.2d[1]
   MLS      v2.4h, v14.4h, v9.4h
   ADD v26.4h, v26.4h, v18.4h
   ADD v3.4h, v3.4h, v19.4h
   SQRDMULH v14.4h, v3.4h, v8.4h
   MOV d19, v27.2d[1]
   MOV d20, v4.2d[1]
   MLS      v3.4h, v14.4h, v9.4h
   ADD v27.4h, v27.4h, v19.4h
   ADD v4.4h, v4.4h, v20.4h
   SQRDMULH v14.4h, v4.4h, v8.4h
   MOV d20, v28.2d[1]
   MOV d21, v5.2d[1]
   MLS      v4.4h, v14.4h, v9.4h
   ADD v28.4h, v28.4h, v20.4h
   ADD v5.4h, v5.4h, v21.4h
   SQRDMULH v14.4h, v5.4h, v8.4h
   MOV d21, v29.2d[1]
   MOV d22, v6.2d[1]
   MLS      v5.4h, v14.4h, v9.4h
   ADD v29.4h, v29.4h, v21.4h
   ADD v6.4h, v6.4h, v22.4h
   SQRDMULH v14.4h, v6.4h, v8.4h
   MOV d22, v30.2d[1]
   MOV d23, v7.2d[1]
   MLS      v6.4h, v14.4h, v9.4h
   ADD v30.4h, v30.4h, v22.4h
   ADD v7.4h, v7.4h, v23.4h
   SQRDMULH v14.4h, v7.4h, v8.4h
   MOV d23, v31.2d[1]
   MLS      v7.4h, v14.4h, v9.4h
   ADD v31.4h, v31.4h, v23.4h

   // b8: v24-v31
   SQRDMULH v14.4h, v24.4h, v8.4h
   MLS      v24.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v25.4h, v8.4h
   MLS      v25.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v26.4h, v8.4h
   MLS      v26.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v27.4h, v8.4h
   MLS      v27.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v28.4h, v8.4h
   MLS      v28.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v29.4h, v8.4h
   MLS      v29.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v30.4h, v8.4h
   MLS      v30.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v31.4h, v8.4h
   MLS      v31.4h, v14.4h, v9.4h

   // a8b8 [0-7] * [24-31]
   //;c[0]&c[14]
   SMULL    v14.4S,  v24.4h,  v0.4h
   SMULL    v15.4S,  v31.4h,  v7.4h
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #0*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #14*8+1024]

   //;c[1]&c[13]
   SMULL    v14.4S,  v24.4h,  v1.4h
   SMULL    v15.4S,  v30.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v6.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #1*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #13*8+1024]

   //;c[2]&c[12]
   SMULL    v14.4S,  v24.4h,  v2.4h
   SMULL    v15.4S,  v29.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v5.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #2*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #12*8+1024]

   //;c[3]&c[11]
   SMULL    v14.4S,  v24.4h,  v3.4h
   SMULL    v15.4S,  v28.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v4.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #3*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #11*8+1024]

   //;c[4]&c[10]
   SMULL    v14.4S,  v24.4h,  v4.4h
   SMULL    v15.4S,  v27.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v3.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #4*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #10*8+1024]

   //;c[5]&c[9]
   SMULL    v14.4S,  v24.4h,  v5.4h
   SMULL    v15.4S,  v26.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v2.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #5*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #9*8+1024]

   //;c[6]&c[8]
   SMULL    v14.4S,  v24.4h,  v6.4h
   SMULL    v15.4S,  v25.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v5.4h
   SMLAL    v15.4S,  v26.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v1.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #6*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #8*8+1024]

   //;c[7]
   SMULL    v14.4S,  v24.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v1.4h
   SMLAL    v14.4S,  v31.4h,  v0.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v10.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v10.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+1024]


   //Butterfly & itranspose
   //[16-23] = arg0 = mc[1][i+4] + mc[2][i];
   //load mc[1][i+4]
   ldr q16, [x4, #0*16+64*3]
   ldr q17, [x4, #1*16+64*3]
   ldr q18, [x4, #2*16+64*3]
   ldr q19, [x4, #3*16+64*3]
   //load mc[2][i]
   ldr q8, [x4, #0*16+64*4]
   ldr q9, [x4, #1*16+64*4]
   ldr q10, [x4, #2*16+64*4]
   ldr q11, [x4, #3*16+64*4]
   ADD v16.8h, v16.8h, v8.8h
   ADD v17.8h, v17.8h, v9.8h
   ADD v18.8h, v18.8h, v10.8h
   ADD v19.8h, v19.8h, v11.8h

   //[24-31] = arg3 = mc[2][i+4] - mc[3][i];
   //load mc[2][i+8]
   ldr q24, [x4, #0*16+64*5]
   ldr q25, [x4, #1*16+64*5]
   ldr q26, [x4, #2*16+64*5]
   ldr q27, [x4, #3*16+64*5]
   //load mc[3][i]
   ldr q8, [x4, #0*16+64*6]
   ldr q9, [x4, #1*16+64*6]
   ldr q10, [x4, #2*16+64*6]
   ldr q11, [x4, #3*16+64*6]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i] = mc[5][i+4] - arg3
   //load mc[5][i+8]
   ldr q0, [x4, #0*16+64*11]
   ldr q1, [x4, #1*16+64*11]
   ldr q2, [x4, #2*16+64*11]
   ldr q3, [x4, #3*16+64*11]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h

   //[24-31] = arg4 = arg3 + mc[5][i] - arg0
   //load  mc[5][i]
   ldr q8, [x4, #0*16+64*10]
   ldr q9, [x4, #1*16+64*10]
   ldr q10, [x4, #2*16+64*10]
   ldr q11, [x4, #3*16+64*10]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   SUB v24.8h, v24.8h, v16.8h
   SUB v25.8h, v25.8h, v17.8h
   SUB v26.8h, v26.8h, v18.8h
   SUB v27.8h, v27.8h, v19.8h

   //store arg0 in mc[1][i+8] [16-23]
   str q16, [x4, #0*16+64*3]
   str q17, [x4, #1*16+64*3]
   str q18, [x4, #2*16+64*3]
   str q19, [x4, #3*16+64*3]

   //store arg4 in mc[2][i]   [24-31]
   str q24, [x4, #0*16+64*4]
   str q25, [x4, #1*16+64*4]
   str q26, [x4, #2*16+64*4]
   str q27, [x4, #3*16+64*4]

   //[24-31] out[2][i+4] = arg4 - mc[3][i+4];
   //load  mc[3][i+4]
   ldr q8, [x4, #0*16+64*7]
   ldr q9, [x4, #1*16+64*7]
   ldr q10, [x4, #2*16+64*7]
   ldr q11, [x4, #3*16+64*7]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i]   = mc[5][i+8] - arg3 - mc[3][i+4];
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h

   //itranspose & store out[3][i+4] = mc[3][i+4]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   //barrett
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h
   str q12, [x0, #0*128+7*16+2]
   mov      w9,  #0
   DUP      v8.8H,  w9
   EXT v13.16b, v8.16b, v13.16b, #14
   str q13, [x0, #1*128+7*16]

   //out[2][i+4] = barrett_fake(arg4 - mc[3][i+4] + mc[7][i+4]);
   //load  mc[7][i+4]
   ldr q8, [x4, #0*16+64*15]
   ldr q9, [x4, #1*16+64*15]
   ldr q10, [x4, #2*16+64*15]
   ldr q11, [x4, #3*16+64*15]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[2][i+4]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+5*16+2]
   str q29, [x0, #1*128+5*16+2]


   //[0-7]  = out[3][i]
   //barrett
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //out[2][i] = mc[8][i+4] - (mc[7][i+4] +  out[3][i])
   ADD v8.8h, v8.8h, v0.8h
   ADD v9.8h, v9.8h, v1.8h
   ADD v10.8h, v10.8h, v2.8h
   ADD v11.8h, v11.8h, v3.8h
   //load mc[8][i+8]
   ldr q16, [x4, #0*16+64*17]
   ldr q17, [x4, #1*16+64*17]
   ldr q18, [x4, #2*16+64*17]
   ldr q19, [x4, #3*16+64*17]
   SUB v8.8h, v16.8h, v8.8h
   SUB v9.8h, v17.8h, v9.8h
   SUB v10.8h, v18.8h, v10.8h
   SUB v11.8h, v19.8h, v11.8h

   //itranspose & store out[3][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+6*16+2]
   str q5, [x0, #1*128+6*16+2]


   //[8-15] = out[2][i]
   //[24-31]  = arg1
   //arg1 = mc[1][i] - mc[0][i+8]
   //load mc[1][i]
   ldr q24, [x4, #0*16+64*2]
   ldr q25, [x4, #1*16+64*2]
   ldr q26, [x4, #2*16+64*2]
   ldr q27, [x4, #3*16+64*2]
   //load mc[0][i+8]
   ldr q0, [x4, #0*16+64*1]
   ldr q1, [x4, #1*16+64*1]
   ldr q2, [x4, #2*16+64*1]
   ldr q3, [x4, #3*16+64*1]
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h

   //[0-7] = arg0 => arg2 = arg1 - arg0 +  mc[4][i+8]
   //load arg0
   ldr q0, [x4, #0*16+64*3]
   ldr q1, [x4, #1*16+64*3]
   ldr q2, [x4, #2*16+64*3]
   ldr q3, [x4, #3*16+64*3]
   SUB v0.8h, v24.8h, v0.8h
   SUB v1.8h, v25.8h, v1.8h
   SUB v2.8h, v26.8h, v2.8h
   SUB v3.8h, v27.8h, v3.8h
   //load mc[4][i+8] 
   ldr q16, [x4, #0*16+64*9]
   ldr q17, [x4, #1*16+64*9]
   ldr q18, [x4, #2*16+64*9]
   ldr q19, [x4, #3*16+64*9]
   ADD v0.8h, v0.8h, v16.8h
   ADD v1.8h, v1.8h, v17.8h
   ADD v2.8h, v2.8h, v18.8h
   ADD v3.8h, v3.8h, v19.8h

   //[0-7] = arg2
   //[8-15] = out[2][i] - arg2
   SUB v8.8h, v8.8h, v0.8h
   SUB v9.8h, v9.8h, v1.8h
   SUB v10.8h, v10.8h, v2.8h
   SUB v11.8h, v11.8h, v3.8h
   //store out[2][i] - arg2 
   str q8, [x4, #0*16+64*3]
   str q9, [x4, #1*16+64*3]
   str q10, [x4, #2*16+64*3]
   str q11, [x4, #3*16+64*3]

   //[8-15] = mc[0][i];
   //load mc[0][i]
   ldr q8, [x4, #0*16]
   ldr q9, [x4, #1*16]
   ldr q10, [x4, #2*16]
   ldr q11, [x4, #3*16]

   //[0-7] = arg2 - mc[0][i]
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   //[24-31] = arg1 + mc[0][i]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[0][i] = mc[0][i]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h

   str q12, [x0, #0*128+0*16+2]
   str q13, [x0, #1*128+0*16+2]

   //[24-31] = arg1 + mc[0][i]; [0-7] = arg2 - mc[0][i]
   //out[0][i+4] = barrett_fake(mc[4][i]   - (mc[0][i]   +  arg1));
   //load mc[4][i]
   ldr q8, [x4, #0*16+64*8]
   ldr q9, [x4, #1*16+64*8]
   ldr q10, [x4, #2*16+64*8]
   ldr q11, [x4, #3*16+64*8]
   //out[0][i+8]
   SUB v24.8h, v8.8h, v24.8h
   SUB v25.8h, v9.8h, v25.8h
   SUB v26.8h, v10.8h, v26.8h
   SUB v27.8h, v11.8h, v27.8h

   //barrett out[0][i+8]
   //;v18, v19 = 7, 4591
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h

   //[0-7] = out[1][i] = arg2 - mc[0][i] + mc[6][i]
   //load  [8-15] mc[6][i]
   ldr q8, [x4, #0*16+64*12]
   ldr q9, [x4, #1*16+64*12]
   ldr q10, [x4, #2*16+64*12]
   ldr q11, [x4, #3*16+64*12]
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   //[8-15] mc[6][i] + out[0][i+8]
   ADD v8.8h, v8.8h, v24.8h
   ADD v9.8h, v9.8h, v25.8h
   ADD v10.8h, v10.8h, v26.8h
   ADD v11.8h, v11.8h, v27.8h

   //itranspose & store out[0][i+8]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+1*16+2]
   str q29, [x0, #1*128+1*16+2]

   //[0-7]barrett_fake(out[1][i])
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+2*16+2]
   str q5, [x0, #1*128+2*16+2]

   //[8-15] mc[6][i] + out[0][i+4]
   //[0-7] arg5 = mc[6][i+4] - mc[7][i];
   //load mc[6][i+4]
   ldr q0, [x4, #0*16+64*13]
   ldr q1, [x4, #1*16+64*13]
   ldr q2, [x4, #2*16+64*13]
   ldr q3, [x4, #3*16+64*13]
   //load mc[7][i]
   ldr q16, [x4, #0*16+64*14]
   ldr q17, [x4, #1*16+64*14]
   ldr q18, [x4, #2*16+64*14]
   ldr q19, [x4, #3*16+64*14]
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h


   //[24-31] =  out[2][i] - arg2
   //load out[2][i] - arg2 
   ldr q24, [x4, #0*16+64*3]
   ldr q25, [x4, #1*16+64*3]
   ldr q26, [x4, #2*16+64*3]
   ldr q27, [x4, #3*16+64*3]
   //out[2][i] - arg2 - arg5
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h
   //barrett out[2][i]
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h
   
   //itranspose & store out[2][i]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+4*16+2]
   str q29, [x0, #1*128+4*16+2]

   //[8-15] mc[6][i] + out[0][i+4]; [0-7] = arg5
   //out[1][i+4] = barrett_fake(arg5 + mc[8][i]   - (arg4 + mc[6][i] + out[0][i+4]));
   //load mc[8][i] 
   ldr q24, [x4, #0*16+64*16]
   ldr q25, [x4, #1*16+64*16]
   ldr q26, [x4, #2*16+64*16]
   ldr q27, [x4, #3*16+64*16]
   ADD v0.8h, v0.8h, v24.8h
   ADD v1.8h, v1.8h, v25.8h
   ADD v2.8h, v2.8h, v26.8h
   ADD v3.8h, v3.8h, v27.8h
   //load arg4
   ldr q24, [x4, #0*16+64*4]
   ldr q25, [x4, #1*16+64*4]
   ldr q26, [x4, #2*16+64*4]
   ldr q27, [x4, #3*16+64*4]
   //(arg4 + mc[6][i] + out[0][i+8])
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   //out[1][i+8]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h


   //barrett out[1][i+8]
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i+8]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+3*16+2]
   str q5, [x0, #1*128+3*16+2]
   ret


__asm_4x32x32_fx1:
___asm_4x32x32_fx1:
   mov      w5,  #0
   DUP      v0.8h,  w5
   str q0, [x0, #0*128+0*16] 
   str q0, [x4, #112+0*128]
   str q0, [x4, #112+1*128]
   str q0, [x4, #112+2*128]
   str q0, [x4, #112+3*128]
   str q0, [x4, #112+4*128]
   str q0, [x4, #112+5*128]
   str q0, [x4, #112+6*128]
   str q0, [x4, #112+7*128]
   str q0, [x4, #112+8*128]
   str q0, [x4, #112+9*128]
   str q0, [x4, #112+10*128]

   //a0a1:v16-v23
   ldr q8, [x1, #0*64]
   ldr q12, [x1, #0*64+16]
   ldr q9, [x1, #1*64]
   ldr q13, [x1, #1*64+16]
   ldr q10, [x1, #2*64]
   ldr q14, [x1, #2*64+16]
   ldr q11, [x1, #3*64]
   ldr q15, [x1, #3*64+16]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d
   trn2 v23.2d, v11.2d, v15.2d


   //b0b1:v24-v31
   ldr q8, [x2, #0]
   ldr q12, [x2, #16]
   ldr q9, [x3, #0]
   ldr q13, [x3, #16]
   ldr q10, [x2, #0]
   ldr q14, [x2, #16]
   ldr q11, [x3, #0]
   ldr q15, [x3, #16]

   trn1 v24.4s, v8.4s, v10.4s
   trn1 v26.4s, v9.4s, v11.4s
   trn1 v28.4s, v12.4s, v14.4s
   trn1 v30.4s, v13.4s, v15.4s
   trn2 v25.4s, v8.4s, v10.4s
   trn2 v27.4s, v9.4s, v11.4s
   trn2 v29.4s, v12.4s, v14.4s
   trn2 v31.4s, v13.4s, v15.4s

   trn1 v8.8h, v24.8h, v26.8h
   trn1 v10.8h, v25.8h, v27.8h
   trn1 v12.8h, v28.8h, v30.8h
   trn1 v14.8h, v29.8h, v31.8h
   trn2 v9.8h, v24.8h, v26.8h
   trn2 v11.8h, v25.8h, v27.8h
   trn2 v13.8h, v28.8h, v30.8h
   trn2 v15.8h, v29.8h, v31.8h

   trn1 v24.2d, v8.2d, v12.2d
   trn1 v25.2d, v9.2d, v13.2d
   trn1 v26.2d, v10.2d, v14.2d    
   trn1 v27.2d, v11.2d, v15.2d
   trn2 v28.2d, v8.2d, v12.2d
   trn2 v29.2d, v9.2d, v13.2d
   trn2 v30.2d, v10.2d, v14.2d    
   trn2 v31.2d, v11.2d, v15.2d

   //a0b0 [16-23] * [24-31]
   //;c[0]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v16.4h,  v24.4h
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+128]
   //;c[1]
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
   STR      d13,     [x4, #1*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+128]
   //;c[2]
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
   STR      d13,     [x4, #2*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+128]
   //;c[3]
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
   STR      d13,     [x4, #3*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+128]
   //;c[4]
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
   STR      d13,     [x4, #4*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+128]
   //;c[5]
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
   STR      d13,     [x4, #5*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+128]
   //;c[6]
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
   STR      d13,     [x4, #6*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+128]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+0]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+128]


   //;c[7]
   SMULL    v14.4S,  v16.4h,  v31.4h
   SMULL2    v15.4S,  v16.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v30.4h
   SMLAL2    v15.4S,  v17.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v29.4h
   SMLAL2    v15.4S,  v18.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v28.4h
   SMLAL2    v15.4S,  v19.8h,  v28.8h
   SMLAL    v14.4S,  v20.4h,  v27.4h
   SMLAL2    v15.4S,  v20.8h,  v27.8h
   SMLAL    v14.4S,  v21.4h,  v26.4h
   SMLAL2    v15.4S,  v21.8h,  v26.8h
   SMLAL    v14.4S,  v22.4h,  v25.4h
   SMLAL2    v15.4S,  v22.8h,  v25.8h
   SMLAL    v14.4S,  v23.4h,  v24.4h
   SMLAL2    v15.4S,  v23.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+0]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+128]
   

   //a2a3:v0-v7
   ldr q8, [x1, #0*64+32]
   ldr q12, [x1, #0*64+48]
   ldr q9, [x1, #1*64+32]
   ldr q13, [x1, #1*64+48]
   ldr q10, [x1, #2*64+32]
   ldr q14, [x1, #2*64+48]
   ldr q11, [x1, #3*64+32]
   ldr q15, [x1, #3*64+48]

   trn1 v0.4s, v8.4s, v10.4s
   trn1 v2.4s, v9.4s, v11.4s
   trn1 v4.4s, v12.4s, v14.4s
   trn1 v6.4s, v13.4s, v15.4s
   trn2 v1.4s, v8.4s, v10.4s
   trn2 v3.4s, v9.4s, v11.4s
   trn2 v5.4s, v12.4s, v14.4s
   trn2 v7.4s, v13.4s, v15.4s

   trn1 v8.8h, v0.8h, v2.8h
   trn1 v10.8h, v1.8h, v3.8h
   trn1 v12.8h, v4.8h, v6.8h
   trn1 v14.8h, v5.8h, v7.8h
   trn2 v9.8h, v0.8h, v2.8h
   trn2 v11.8h, v1.8h, v3.8h
   trn2 v13.8h, v4.8h, v6.8h
   trn2 v15.8h, v5.8h, v7.8h

   trn1 v0.2d, v8.2d, v12.2d
   trn1 v1.2d, v9.2d, v13.2d
   trn1 v2.2d, v10.2d, v14.2d    
   trn1 v3.2d, v11.2d, v15.2d
   trn2 v4.2d, v8.2d, v12.2d
   trn2 v5.2d, v9.2d, v13.2d
   trn2 v6.2d, v10.2d, v14.2d    
   trn2 v7.2d, v11.2d, v15.2d

   // a6a7 = a0a1+a2a3:v16-v23
   add v16.8h, v16.8h, v0.8h
   add v17.8h, v17.8h, v1.8h
   add v18.8h, v18.8h, v2.8h
   add v19.8h, v19.8h, v3.8h
   add v20.8h, v20.8h, v4.8h
   add v21.8h, v21.8h, v5.8h
   add v22.8h, v22.8h, v6.8h
   add v23.8h, v23.8h, v7.8h

   //store a6a7
   str q16, [x4, #0*16+9*128]
   str q17, [x4, #1*16+9*128]
   str q18, [x4, #2*16+9*128]
   str q19, [x4, #3*16+9*128]
   str q20, [x4, #4*16+9*128]
   str q21, [x4, #5*16+9*128]
   str q22, [x4, #6*16+9*128]
   str q23, [x4, #7*16+9*128]

   //b2b3:v16-v23
   ldr q8, [x2, #32]
   ldr q12, [x2, #48]
   ldr q9, [x3, #32]
   ldr q13, [x3, #48]
   ldr q10, [x2, #32]
   ldr q14, [x2, #48]
   ldr q11, [x3, #32]
   ldr q15, [x3, #48]

   trn1 v16.4s, v8.4s, v10.4s
   trn1 v18.4s, v9.4s, v11.4s
   trn1 v20.4s, v12.4s, v14.4s
   trn1 v22.4s, v13.4s, v15.4s
   trn2 v17.4s, v8.4s, v10.4s
   trn2 v19.4s, v9.4s, v11.4s
   trn2 v21.4s, v12.4s, v14.4s
   trn2 v23.4s, v13.4s, v15.4s

   trn1 v8.8h, v16.8h, v18.8h
   trn1 v10.8h, v17.8h, v19.8h
   trn1 v12.8h, v20.8h, v22.8h
   trn1 v14.8h, v21.8h, v23.8h
   trn2 v9.8h, v16.8h, v18.8h
   trn2 v11.8h, v17.8h, v19.8h
   trn2 v13.8h, v20.8h, v22.8h
   trn2 v15.8h, v21.8h, v23.8h

   trn1 v16.2d, v8.2d, v12.2d
   trn1 v17.2d, v9.2d, v13.2d
   trn1 v18.2d, v10.2d, v14.2d    
   trn1 v19.2d, v11.2d, v15.2d
   trn2 v20.2d, v8.2d, v12.2d
   trn2 v21.2d, v9.2d, v13.2d
   trn2 v22.2d, v10.2d, v14.2d    
   trn2 v23.2d, v11.2d, v15.2d

   //b6b7 = b2b3 + b0b1:v24-v31
   add v24.8h, v16.8h, v24.8h
   add v25.8h, v17.8h, v25.8h
   add v26.8h, v18.8h, v26.8h
   add v27.8h, v19.8h, v27.8h
   add v28.8h, v20.8h, v28.8h
   add v29.8h, v21.8h, v29.8h
   add v30.8h, v22.8h, v30.8h
   add v31.8h, v23.8h, v31.8h

   //a2b2 [0-7] * [16-23]
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7
   mov      w5,  #4591
   DUP      v9.8H,  w5

   //;c[0]
   SMULL    v14.4S,  v0.4h,  v16.4h
   SMULL2   v15.4S,  v0.8h,  v16.8h
   SMULL    v11.4S,  v7.4h,  v23.4h
   SMULL2   v12.4S,  v7.8h,  v23.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+384]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v17.4h
   SMULL2   v15.4S,  v0.8h,  v17.8h
   SMULL    v11.4S,  v6.4h,  v23.4h
   SMULL2   v12.4S,  v6.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v16.4h
   SMLAL2   v15.4S,  v1.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v22.4h
   SMLAL2   v12.4S,  v7.8h,  v22.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+384]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v18.4h
   SMULL2   v15.4S,  v0.8h,  v18.8h
   SMULL    v11.4S,  v5.4h,  v23.4h
   SMULL2   v12.4S,  v5.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v17.4h
   SMLAL2   v15.4S,  v1.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v22.4h
   SMLAL2   v12.4S,  v6.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v16.4h
   SMLAL2   v15.4S,  v2.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v21.4h
   SMLAL2   v12.4S,  v7.8h,  v21.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+384]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v19.4h
   SMULL2   v15.4S,  v0.8h,  v19.8h
   SMULL    v11.4S,  v4.4h,  v23.4h
   SMULL2   v12.4S,  v4.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v18.4h
   SMLAL2   v15.4S,  v1.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v22.4h
   SMLAL2   v12.4S,  v5.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v17.4h
   SMLAL2   v15.4S,  v2.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v21.4h
   SMLAL2   v12.4S,  v6.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v16.4h
   SMLAL2   v15.4S,  v3.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v20.4h
   SMLAL2   v12.4S,  v7.8h,  v20.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+384]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v20.4h
   SMULL2   v15.4S,  v0.8h,  v20.8h
   SMULL    v11.4S,  v3.4h,  v23.4h
   SMULL2   v12.4S,  v3.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v19.4h
   SMLAL2   v15.4S,  v1.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v22.4h
   SMLAL2   v12.4S,  v4.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v18.4h
   SMLAL2   v15.4S,  v2.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v21.4h
   SMLAL2   v12.4S,  v5.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v17.4h
   SMLAL2   v15.4S,  v3.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v20.4h
   SMLAL2   v12.4S,  v6.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v16.4h
   SMLAL2   v15.4S,  v4.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v19.4h
   SMLAL2   v12.4S,  v7.8h,  v19.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+384]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v21.4h
   SMULL2   v15.4S,  v0.8h,  v21.8h
   SMULL    v11.4S,  v2.4h,  v23.4h
   SMULL2   v12.4S,  v2.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v20.4h
   SMLAL2   v15.4S,  v1.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v22.4h
   SMLAL2   v12.4S,  v3.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v19.4h
   SMLAL2   v15.4S,  v2.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v21.4h
   SMLAL2   v12.4S,  v4.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v18.4h
   SMLAL2   v15.4S,  v3.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v20.4h
   SMLAL2   v12.4S,  v5.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v17.4h
   SMLAL2   v15.4S,  v4.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v19.4h
   SMLAL2   v12.4S,  v6.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v16.4h
   SMLAL2   v15.4S,  v5.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v18.4h
   SMLAL2   v12.4S,  v7.8h,  v18.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+384]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v22.4h
   SMULL2   v15.4S,  v0.8h,  v22.8h
   SMULL    v11.4S,  v1.4h,  v23.4h
   SMULL2   v12.4S,  v1.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v21.4h
   SMLAL2   v15.4S,  v1.8h,  v21.8h
   SMLAL    v11.4S,  v2.4h,  v22.4h
   SMLAL2   v12.4S,  v2.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v20.4h
   SMLAL2   v15.4S,  v2.8h,  v20.8h
   SMLAL    v11.4S,  v3.4h,  v21.4h
   SMLAL2   v12.4S,  v3.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v19.4h
   SMLAL2   v15.4S,  v3.8h,  v19.8h
   SMLAL    v11.4S,  v4.4h,  v20.4h
   SMLAL2   v12.4S,  v4.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v18.4h
   SMLAL2   v15.4S,  v4.8h,  v18.8h
   SMLAL    v11.4S,  v5.4h,  v19.4h
   SMLAL2   v12.4S,  v5.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v17.4h
   SMLAL2   v15.4S,  v5.8h,  v17.8h
   SMLAL    v11.4S,  v6.4h,  v18.4h
   SMLAL2   v12.4S,  v6.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v16.4h
   SMLAL2   v15.4S,  v6.8h,  v16.8h
   SMLAL    v11.4S,  v7.4h,  v17.4h
   SMLAL2   v12.4S,  v7.8h,  v17.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+384]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+256]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+384]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v23.4h
   SMULL2    v15.4S,  v0.8h,  v23.8h
   SMLAL    v14.4S,  v1.4h,  v22.4h
   SMLAL2    v15.4S,  v1.8h,  v22.8h
   SMLAL    v14.4S,  v2.4h,  v21.4h
   SMLAL2    v15.4S,  v2.8h,  v21.8h
   SMLAL    v14.4S,  v3.4h,  v20.4h
   SMLAL2    v15.4S,  v3.8h,  v20.8h
   SMLAL    v14.4S,  v4.4h,  v19.4h
   SMLAL2    v15.4S,  v4.8h,  v19.8h
   SMLAL    v14.4S,  v5.4h,  v18.4h
   SMLAL2    v15.4S,  v5.8h,  v18.8h
   SMLAL    v14.4S,  v6.4h,  v17.4h
   SMLAL2    v15.4S,  v6.8h,  v17.8h
   SMLAL    v14.4S,  v7.4h,  v16.4h
   SMLAL2    v15.4S,  v7.8h,  v16.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+256]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+384]

   //store a2a3
   str q0, [x4, #0*16+10*128]
   str q1, [x4, #1*16+10*128]
   str q2, [x4, #2*16+10*128]
   str q3, [x4, #3*16+10*128]
   str q4, [x4, #4*16+10*128]
   str q5, [x4, #5*16+10*128]
   str q6, [x4, #6*16+10*128]
   str q7, [x4, #7*16+10*128]

   //load a6a7: v0-v7
   ldr q0, [x4, #0*16+9*128]
   ldr q1, [x4, #1*16+9*128]
   ldr q2, [x4, #2*16+9*128]
   ldr q3, [x4, #3*16+9*128]
   ldr q4, [x4, #4*16+9*128]
   ldr q5, [x4, #5*16+9*128]
   ldr q6, [x4, #6*16+9*128]
   ldr q7, [x4, #7*16+9*128]

   // a6b6 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+896]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+896]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+896]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+896]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+896]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+896]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+896]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+768]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+896]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+768]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+896]

   //b0b1 = b6b7 - b2b3:v8-v15
   SUB v8.8h, v24.8h, v16.8h
   SUB v9.8h, v25.8h, v17.8h
   SUB v10.8h, v26.8h, v18.8h
   SUB v11.8h, v27.8h, v19.8h
   SUB v12.8h, v28.8h, v20.8h
   SUB v13.8h, v29.8h, v21.8h
   SUB v14.8h, v30.8h, v22.8h
   SUB v15.8h, v31.8h, v23.8h

   //transpose
   //b0b2: v24-v31
   trn1 v24.2d, v8.2d, v16.2d
   trn1 v25.2d, v9.2d, v17.2d
   trn1 v26.2d, v10.2d, v18.2d    
   trn1 v27.2d, v11.2d, v19.2d
   trn1 v28.2d, v12.2d, v20.2d
   trn1 v29.2d, v13.2d, v21.2d
   trn1 v30.2d, v14.2d, v22.2d    
   trn1 v31.2d, v15.2d, v23.2d

   //b1b3: v16-v23
   trn2 v16.2d, v8.2d, v16.2d
   trn2 v17.2d, v9.2d, v17.2d
   trn2 v18.2d, v10.2d, v18.2d    
   trn2 v19.2d, v11.2d, v19.2d
   trn2 v20.2d, v12.2d, v20.2d
   trn2 v21.2d, v13.2d, v21.2d
   trn2 v22.2d, v14.2d, v22.2d    
   trn2 v23.2d, v15.2d, v23.2d

   //b4b5: v24-v31
   ADD v24.8h, v24.8h, v16.8h
   ADD v25.8h, v25.8h, v17.8h
   ADD v26.8h, v26.8h, v18.8h
   ADD v27.8h, v27.8h, v19.8h
   ADD v28.8h, v28.8h, v20.8h
   ADD v29.8h, v29.8h, v21.8h
   ADD v30.8h, v30.8h, v22.8h
   ADD v31.8h, v31.8h, v23.8h

   //load a2a3: v16-v23
   ldr q16, [x4, #0*16+10*128]
   ldr q17, [x4, #1*16+10*128]
   ldr q18, [x4, #2*16+10*128]
   ldr q19, [x4, #3*16+10*128]
   ldr q20, [x4, #4*16+10*128]
   ldr q21, [x4, #5*16+10*128]
   ldr q22, [x4, #6*16+10*128]
   ldr q23, [x4, #7*16+10*128]


   //a0a1 = a6a7 - a2a3:v0-v8
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h
   SUB v4.8h, v4.8h, v20.8h
   SUB v5.8h, v5.8h, v21.8h
   SUB v6.8h, v6.8h, v22.8h
   SUB v7.8h, v7.8h, v23.8h

   //transpose
   // a0a2: v8-v15
   trn1 v8.2d, v0.2d, v16.2d
   trn1 v9.2d, v1.2d, v17.2d
   trn1 v10.2d, v2.2d, v18.2d
   trn1 v11.2d, v3.2d, v19.2d
   trn1 v12.2d, v4.2d, v20.2d
   trn1 v13.2d, v5.2d, v21.2d
   trn1 v14.2d, v6.2d, v22.2d
   trn1 v15.2d, v7.2d, v23.2d

   // a1a3: v0-v7
   trn2 v0.2d, v0.2d, v16.2d
   trn2 v1.2d, v1.2d, v17.2d
   trn2 v2.2d, v2.2d, v18.2d
   trn2 v3.2d, v3.2d, v19.2d
   trn2 v4.2d, v4.2d, v20.2d
   trn2 v5.2d, v5.2d, v21.2d
   trn2 v6.2d, v6.2d, v22.2d
   trn2 v7.2d, v7.2d, v23.2d

   // a4a5: v0-v7
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   ADD v4.8h, v4.8h, v12.8h
   ADD v5.8h, v5.8h, v13.8h
   ADD v6.8h, v6.8h, v14.8h
   ADD v7.8h, v7.8h, v15.8h

   //load t
   mov      w5,  #4591
   DUP      v9.8H,  w5
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //a4b4 [0-7] * [24-31]
   //;c[0]
   SMULL    v14.4S,  v0.4h,  v24.4h
   SMULL2   v15.4S,  v0.8h,  v24.8h
   SMULL    v11.4S,  v7.4h,  v31.4h
   SMULL2   v12.4S,  v7.8h,  v31.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #0*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #0*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #14*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #14*8+640]
   //;c[1]
   SMULL    v14.4S,  v0.4h,  v25.4h
   SMULL2   v15.4S,  v0.8h,  v25.8h
   SMULL    v11.4S,  v6.4h,  v31.4h
   SMULL2   v12.4S,  v6.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v24.4h
   SMLAL2   v15.4S,  v1.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v30.4h
   SMLAL2   v12.4S,  v7.8h,  v30.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #1*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #1*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #13*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #13*8+640]
   //;c[2]
   SMULL    v14.4S,  v0.4h,  v26.4h
   SMULL2   v15.4S,  v0.8h,  v26.8h
   SMULL    v11.4S,  v5.4h,  v31.4h
   SMULL2   v12.4S,  v5.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v25.4h
   SMLAL2   v15.4S,  v1.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v30.4h
   SMLAL2   v12.4S,  v6.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v24.4h
   SMLAL2   v15.4S,  v2.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v29.4h
   SMLAL2   v12.4S,  v7.8h,  v29.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #2*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #2*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #12*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #12*8+640]
   //;c[3]
   SMULL    v14.4S,  v0.4h,  v27.4h
   SMULL2   v15.4S,  v0.8h,  v27.8h
   SMULL    v11.4S,  v4.4h,  v31.4h
   SMULL2   v12.4S,  v4.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v26.4h
   SMLAL2   v15.4S,  v1.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v30.4h
   SMLAL2   v12.4S,  v5.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v25.4h
   SMLAL2   v15.4S,  v2.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v29.4h
   SMLAL2   v12.4S,  v6.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v24.4h
   SMLAL2   v15.4S,  v3.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v28.4h
   SMLAL2   v12.4S,  v7.8h,  v28.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #3*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #3*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #11*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #11*8+640]
   //;c[4]
   SMULL    v14.4S,  v0.4h,  v28.4h
   SMULL2   v15.4S,  v0.8h,  v28.8h
   SMULL    v11.4S,  v3.4h,  v31.4h
   SMULL2   v12.4S,  v3.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v27.4h
   SMLAL2   v15.4S,  v1.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v30.4h
   SMLAL2   v12.4S,  v4.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v26.4h
   SMLAL2   v15.4S,  v2.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v29.4h
   SMLAL2   v12.4S,  v5.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v25.4h
   SMLAL2   v15.4S,  v3.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v28.4h
   SMLAL2   v12.4S,  v6.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v24.4h
   SMLAL2   v15.4S,  v4.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v27.4h
   SMLAL2   v12.4S,  v7.8h,  v27.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #4*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #4*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #10*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #10*8+640]
   //;c[5]
   SMULL    v14.4S,  v0.4h,  v29.4h
   SMULL2   v15.4S,  v0.8h,  v29.8h
   SMULL    v11.4S,  v2.4h,  v31.4h
   SMULL2   v12.4S,  v2.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v28.4h
   SMLAL2   v15.4S,  v1.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v30.4h
   SMLAL2   v12.4S,  v3.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v27.4h
   SMLAL2   v15.4S,  v2.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v29.4h
   SMLAL2   v12.4S,  v4.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v26.4h
   SMLAL2   v15.4S,  v3.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v28.4h
   SMLAL2   v12.4S,  v5.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v25.4h
   SMLAL2   v15.4S,  v4.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v27.4h
   SMLAL2   v12.4S,  v6.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v24.4h
   SMLAL2   v15.4S,  v5.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v26.4h
   SMLAL2   v12.4S,  v7.8h,  v26.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #5*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #5*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #9*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #9*8+640]
   //;c[6]
   SMULL    v14.4S,  v0.4h,  v30.4h
   SMULL2   v15.4S,  v0.8h,  v30.8h
   SMULL    v11.4S,  v1.4h,  v31.4h
   SMULL2   v12.4S,  v1.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v29.4h
   SMLAL2   v15.4S,  v1.8h,  v29.8h
   SMLAL    v11.4S,  v2.4h,  v30.4h
   SMLAL2   v12.4S,  v2.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v28.4h
   SMLAL2   v15.4S,  v2.8h,  v28.8h
   SMLAL    v11.4S,  v3.4h,  v29.4h
   SMLAL2   v12.4S,  v3.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v27.4h
   SMLAL2   v15.4S,  v3.8h,  v27.8h
   SMLAL    v11.4S,  v4.4h,  v28.4h
   SMLAL2   v12.4S,  v4.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v26.4h
   SMLAL2   v15.4S,  v4.8h,  v26.8h
   SMLAL    v11.4S,  v5.4h,  v27.4h
   SMLAL2   v12.4S,  v5.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v25.4h
   SMLAL2   v15.4S,  v5.8h,  v25.8h
   SMLAL    v11.4S,  v6.4h,  v26.4h
   SMLAL2   v12.4S,  v6.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v24.4h
   SMLAL2   v15.4S,  v6.8h,  v24.8h
   SMLAL    v11.4S,  v7.4h,  v25.4h
   SMLAL2   v12.4S,  v7.8h,  v25.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      d13,     [x4, #6*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #6*8+640]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      d10,     [x4, #8*8+512]
   DUP      v11.2d,  v10.2d[1]
   STR      d11,     [x4, #8*8+640]


   //;c[7]
   SMULL    v14.4S,  v0.4h,  v31.4h
   SMULL2    v15.4S,  v0.8h,  v31.8h
   SMLAL    v14.4S,  v1.4h,  v30.4h
   SMLAL2    v15.4S,  v1.8h,  v30.8h
   SMLAL    v14.4S,  v2.4h,  v29.4h
   SMLAL2    v15.4S,  v2.8h,  v29.8h
   SMLAL    v14.4S,  v3.4h,  v28.4h
   SMLAL2    v15.4S,  v3.8h,  v28.8h
   SMLAL    v14.4S,  v4.4h,  v27.4h
   SMLAL2    v15.4S,  v4.8h,  v27.8h
   SMLAL    v14.4S,  v5.4h,  v26.4h
   SMLAL2    v15.4S,  v5.8h,  v26.8h
   SMLAL    v14.4S,  v6.4h,  v25.4h
   SMLAL2    v15.4S,  v6.8h,  v25.8h
   SMLAL    v14.4S,  v7.4h,  v24.4h
   SMLAL2    v15.4S,  v7.8h,  v24.8h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+512]
   DUP      v14.2d,  v13.2d[1]
   STR      d14,     [x4, #7*8+640]


   mov      w8, #7
   DUP      v8.8H,  w8
   // mov a5 and b5
   MOV d16, v0.2d[1]
   // a8: v0-v7 & barrett
   ADD v0.4h, v0.4h, v16.4h
   SQRDMULH v14.4h, v0.4h, v8.4h
   MOV d16, v24.2d[1]
   MOV d17, v1.2d[1]
   MLS      v0.4h, v14.4h, v9.4h
   ADD v24.4h, v24.4h, v16.4h
   ADD v1.4h, v1.4h, v17.4h
   SQRDMULH v14.4h, v1.4h, v8.4h
   MOV d17, v25.2d[1]
   MOV d18, v2.2d[1]
   MLS      v1.4h, v14.4h, v9.4h
   ADD v25.4h, v25.4h, v17.4h
   ADD v2.4h, v2.4h, v18.4h
   SQRDMULH v14.4h, v2.4h, v8.4h
   MOV d18, v26.2d[1]
   MOV d19, v3.2d[1]
   MLS      v2.4h, v14.4h, v9.4h
   ADD v26.4h, v26.4h, v18.4h
   ADD v3.4h, v3.4h, v19.4h
   SQRDMULH v14.4h, v3.4h, v8.4h
   MOV d19, v27.2d[1]
   MOV d20, v4.2d[1]
   MLS      v3.4h, v14.4h, v9.4h
   ADD v27.4h, v27.4h, v19.4h
   ADD v4.4h, v4.4h, v20.4h
   SQRDMULH v14.4h, v4.4h, v8.4h
   MOV d20, v28.2d[1]
   MOV d21, v5.2d[1]
   MLS      v4.4h, v14.4h, v9.4h
   ADD v28.4h, v28.4h, v20.4h
   ADD v5.4h, v5.4h, v21.4h
   SQRDMULH v14.4h, v5.4h, v8.4h
   MOV d21, v29.2d[1]
   MOV d22, v6.2d[1]
   MLS      v5.4h, v14.4h, v9.4h
   ADD v29.4h, v29.4h, v21.4h
   ADD v6.4h, v6.4h, v22.4h
   SQRDMULH v14.4h, v6.4h, v8.4h
   MOV d22, v30.2d[1]
   MOV d23, v7.2d[1]
   MLS      v6.4h, v14.4h, v9.4h
   ADD v30.4h, v30.4h, v22.4h
   ADD v7.4h, v7.4h, v23.4h
   SQRDMULH v14.4h, v7.4h, v8.4h
   MOV d23, v31.2d[1]
   MLS      v7.4h, v14.4h, v9.4h
   ADD v31.4h, v31.4h, v23.4h

   // b8: v24-v31
   SQRDMULH v14.4h, v24.4h, v8.4h
   MLS      v24.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v25.4h, v8.4h
   MLS      v25.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v26.4h, v8.4h
   MLS      v26.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v27.4h, v8.4h
   MLS      v27.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v28.4h, v8.4h
   MLS      v28.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v29.4h, v8.4h
   MLS      v29.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v30.4h, v8.4h
   MLS      v30.4h, v14.4h, v9.4h
   SQRDMULH v14.4h, v31.4h, v8.4h
   MLS      v31.4h, v14.4h, v9.4h

   // a8b8 [0-7] * [24-31]
   //;c[0]&c[14]
   SMULL    v14.4S,  v24.4h,  v0.4h
   SMULL    v15.4S,  v31.4h,  v7.4h
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #0*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #14*8+1024]

   //;c[1]&c[13]
   SMULL    v14.4S,  v24.4h,  v1.4h
   SMULL    v15.4S,  v30.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v6.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #1*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #13*8+1024]

   //;c[2]&c[12]
   SMULL    v14.4S,  v24.4h,  v2.4h
   SMULL    v15.4S,  v29.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v5.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #2*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #12*8+1024]

   //;c[3]&c[11]
   SMULL    v14.4S,  v24.4h,  v3.4h
   SMULL    v15.4S,  v28.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v4.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #3*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #11*8+1024]

   //;c[4]&c[10]
   SMULL    v14.4S,  v24.4h,  v4.4h
   SMULL    v15.4S,  v27.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v3.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #4*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #10*8+1024]

   //;c[5]&c[9]
   SMULL    v14.4S,  v24.4h,  v5.4h
   SMULL    v15.4S,  v26.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v2.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #5*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #9*8+1024]

   //;c[6]&c[8]
   SMULL    v14.4S,  v24.4h,  v6.4h
   SMULL    v15.4S,  v25.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v5.4h
   SMLAL    v15.4S,  v26.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v4.4h
   SMLAL    v15.4S,  v27.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v3.4h
   SMLAL    v15.4S,  v28.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v2.4h
   SMLAL    v15.4S,  v29.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v1.4h
   SMLAL    v15.4S,  v30.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v0.4h
   SMLAL    v15.4S,  v31.4h,  v1.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #6*8+1024]
   DUP      v12.2d,  v13.2d[1]
   STR      d12,     [x4, #8*8+1024]

   //;c[7]
   SMULL    v14.4S,  v24.4h,  v7.4h
   SMLAL    v14.4S,  v25.4h,  v6.4h
   SMLAL    v14.4S,  v26.4h,  v5.4h
   SMLAL    v14.4S,  v27.4h,  v4.4h
   SMLAL    v14.4S,  v28.4h,  v3.4h
   SMLAL    v14.4S,  v29.4h,  v2.4h
   SMLAL    v14.4S,  v30.4h,  v1.4h
   SMLAL    v14.4S,  v31.4h,  v0.4h

   //;barrett_32
   UZP1     v13.8h,  v14.8h,  v10.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v10.8h
   MLS      v13.8h,  v9.8h,   v14.8h
   STR      d13,     [x4, #7*8+1024]


   //Butterfly & itranspose
   //[16-23] = arg0 = mc[1][i+4] + mc[2][i];
   //load mc[1][i+4]
   ldr q16, [x4, #0*16+64*3]
   ldr q17, [x4, #1*16+64*3]
   ldr q18, [x4, #2*16+64*3]
   ldr q19, [x4, #3*16+64*3]
   //load mc[2][i]
   ldr q8, [x4, #0*16+64*4]
   ldr q9, [x4, #1*16+64*4]
   ldr q10, [x4, #2*16+64*4]
   ldr q11, [x4, #3*16+64*4]
   ADD v16.8h, v16.8h, v8.8h
   ADD v17.8h, v17.8h, v9.8h
   ADD v18.8h, v18.8h, v10.8h
   ADD v19.8h, v19.8h, v11.8h

   //[24-31] = arg3 = mc[2][i+4] - mc[3][i];
   //load mc[2][i+8]
   ldr q24, [x4, #0*16+64*5]
   ldr q25, [x4, #1*16+64*5]
   ldr q26, [x4, #2*16+64*5]
   ldr q27, [x4, #3*16+64*5]
   //load mc[3][i]
   ldr q8, [x4, #0*16+64*6]
   ldr q9, [x4, #1*16+64*6]
   ldr q10, [x4, #2*16+64*6]
   ldr q11, [x4, #3*16+64*6]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i] = mc[5][i+4] - arg3
   //load mc[5][i+8]
   ldr q0, [x4, #0*16+64*11]
   ldr q1, [x4, #1*16+64*11]
   ldr q2, [x4, #2*16+64*11]
   ldr q3, [x4, #3*16+64*11]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h

   //[24-31] = arg4 = arg3 + mc[5][i] - arg0
   //load  mc[5][i]
   ldr q8, [x4, #0*16+64*10]
   ldr q9, [x4, #1*16+64*10]
   ldr q10, [x4, #2*16+64*10]
   ldr q11, [x4, #3*16+64*10]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   SUB v24.8h, v24.8h, v16.8h
   SUB v25.8h, v25.8h, v17.8h
   SUB v26.8h, v26.8h, v18.8h
   SUB v27.8h, v27.8h, v19.8h

   //store arg0 in mc[1][i+8] [16-23]
   str q16, [x4, #0*16+64*3]
   str q17, [x4, #1*16+64*3]
   str q18, [x4, #2*16+64*3]
   str q19, [x4, #3*16+64*3]

   //store arg4 in mc[2][i]   [24-31]
   str q24, [x4, #0*16+64*4]
   str q25, [x4, #1*16+64*4]
   str q26, [x4, #2*16+64*4]
   str q27, [x4, #3*16+64*4]

   //[24-31] out[2][i+4] = arg4 - mc[3][i+4];
   //load  mc[3][i+4]
   ldr q8, [x4, #0*16+64*7]
   ldr q9, [x4, #1*16+64*7]
   ldr q10, [x4, #2*16+64*7]
   ldr q11, [x4, #3*16+64*7]
   SUB v24.8h, v24.8h, v8.8h
   SUB v25.8h, v25.8h, v9.8h
   SUB v26.8h, v26.8h, v10.8h
   SUB v27.8h, v27.8h, v11.8h

   //[0-7] = out[3][i]   = mc[5][i+8] - arg3 - mc[3][i+4];
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h

   //itranspose & store out[3][i+4] = mc[3][i+4]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   //barrett
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h
   mov      w9,  #0
   DUP      v8.8H,  w9
   EXT v12.16b, v8.16b, v12.16b, #14
   str q12, [x0, #0*128+7*16]
   str q13, [x0, #1*128+7*16]

   //out[2][i+4] = barrett_fake(arg4 - mc[3][i+4] + mc[7][i+4]);
   //load  mc[7][i+4]
   ldr q8, [x4, #0*16+64*15]
   ldr q9, [x4, #1*16+64*15]
   ldr q10, [x4, #2*16+64*15]
   ldr q11, [x4, #3*16+64*15]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[2][i+4]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+5*16+2]
   str q29, [x0, #1*128+5*16]


   //[0-7]  = out[3][i]
   //barrett
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //out[2][i] = mc[8][i+4] - (mc[7][i+4] +  out[3][i])
   ADD v8.8h, v8.8h, v0.8h
   ADD v9.8h, v9.8h, v1.8h
   ADD v10.8h, v10.8h, v2.8h
   ADD v11.8h, v11.8h, v3.8h
   //load mc[8][i+8]
   ldr q16, [x4, #0*16+64*17]
   ldr q17, [x4, #1*16+64*17]
   ldr q18, [x4, #2*16+64*17]
   ldr q19, [x4, #3*16+64*17]
   SUB v8.8h, v16.8h, v8.8h
   SUB v9.8h, v17.8h, v9.8h
   SUB v10.8h, v18.8h, v10.8h
   SUB v11.8h, v19.8h, v11.8h

   //itranspose & store out[3][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+6*16+2]
   str q5, [x0, #1*128+6*16]


   //[8-15] = out[2][i]
   //[24-31]  = arg1
   //arg1 = mc[1][i] - mc[0][i+8]
   //load mc[1][i]
   ldr q24, [x4, #0*16+64*2]
   ldr q25, [x4, #1*16+64*2]
   ldr q26, [x4, #2*16+64*2]
   ldr q27, [x4, #3*16+64*2]
   //load mc[0][i+8]
   ldr q0, [x4, #0*16+64*1]
   ldr q1, [x4, #1*16+64*1]
   ldr q2, [x4, #2*16+64*1]
   ldr q3, [x4, #3*16+64*1]
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h

   //[0-7] = arg0 => arg2 = arg1 - arg0 +  mc[4][i+8]
   //load arg0
   ldr q0, [x4, #0*16+64*3]
   ldr q1, [x4, #1*16+64*3]
   ldr q2, [x4, #2*16+64*3]
   ldr q3, [x4, #3*16+64*3]
   SUB v0.8h, v24.8h, v0.8h
   SUB v1.8h, v25.8h, v1.8h
   SUB v2.8h, v26.8h, v2.8h
   SUB v3.8h, v27.8h, v3.8h
   //load mc[4][i+8] 
   ldr q16, [x4, #0*16+64*9]
   ldr q17, [x4, #1*16+64*9]
   ldr q18, [x4, #2*16+64*9]
   ldr q19, [x4, #3*16+64*9]
   ADD v0.8h, v0.8h, v16.8h
   ADD v1.8h, v1.8h, v17.8h
   ADD v2.8h, v2.8h, v18.8h
   ADD v3.8h, v3.8h, v19.8h

   //[0-7] = arg2
   //[8-15] = out[2][i] - arg2
   SUB v8.8h, v8.8h, v0.8h
   SUB v9.8h, v9.8h, v1.8h
   SUB v10.8h, v10.8h, v2.8h
   SUB v11.8h, v11.8h, v3.8h
   //store out[2][i] - arg2 
   str q8, [x4, #0*16+64*3]
   str q9, [x4, #1*16+64*3]
   str q10, [x4, #2*16+64*3]
   str q11, [x4, #3*16+64*3]

   //[8-15] = mc[0][i];
   //load mc[0][i]
   ldr q8, [x4, #0*16]
   ldr q9, [x4, #1*16]
   ldr q10, [x4, #2*16]
   ldr q11, [x4, #3*16]

   //[0-7] = arg2 - mc[0][i]
   SUB v0.8h, v0.8h, v8.8h
   SUB v1.8h, v1.8h, v9.8h
   SUB v2.8h, v2.8h, v10.8h
   SUB v3.8h, v3.8h, v11.8h
   //[24-31] = arg1 + mc[0][i]
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   
   //itranspose & store out[0][i] = mc[0][i]
   trn1 v12.2d, v8.2d, v10.2d
   trn2 v13.2d, v8.2d, v10.2d
   trn1 v14.2d, v9.2d, v11.2d
   trn2 v15.2d, v9.2d, v11.2d

   trn1 v8.4s, v12.4s, v14.4s
   trn1 v10.4s, v13.4s, v15.4s
   trn2 v9.4s, v12.4s, v14.4s
   trn2 v11.4s, v13.4s, v15.4s

   trn1 v12.8h, v8.8h, v10.8h
   trn1 v14.8h, v9.8h, v11.8h
   trn2 v13.8h, v8.8h, v10.8h
   trn2 v15.8h, v9.8h, v11.8h

   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8

   add v12.8h, v12.8h, v13.8h
   add v13.8h, v14.8h, v15.8h
   SQRDMULH v16.8h, v12.8h,  v18.8h
   MLS      v12.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v13.8h,  v18.8h
   MLS      v13.8h, v16.8h,  v19.8h
   str q12, [x0, #0*128+0*16+2]
   str q13, [x0, #1*128+0*16]

   //[24-31] = arg1 + mc[0][i]; [0-7] = arg2 - mc[0][i]
   //out[0][i+4] = barrett_fake(mc[4][i]   - (mc[0][i]   +  arg1));
   //load mc[4][i]
   ldr q8, [x4, #0*16+64*8]
   ldr q9, [x4, #1*16+64*8]
   ldr q10, [x4, #2*16+64*8]
   ldr q11, [x4, #3*16+64*8]
   //out[0][i+8]
   SUB v24.8h, v8.8h, v24.8h
   SUB v25.8h, v9.8h, v25.8h
   SUB v26.8h, v10.8h, v26.8h
   SUB v27.8h, v11.8h, v27.8h

   //barrett out[0][i+8]
   //;v18, v19 = 7, 4591
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h

   //[0-7] = out[1][i] = arg2 - mc[0][i] + mc[6][i]
   //load  [8-15] mc[6][i]
   ldr q8, [x4, #0*16+64*12]
   ldr q9, [x4, #1*16+64*12]
   ldr q10, [x4, #2*16+64*12]
   ldr q11, [x4, #3*16+64*12]
   ADD v0.8h, v0.8h, v8.8h
   ADD v1.8h, v1.8h, v9.8h
   ADD v2.8h, v2.8h, v10.8h
   ADD v3.8h, v3.8h, v11.8h
   //[8-15] mc[6][i] + out[0][i+8]
   ADD v8.8h, v8.8h, v24.8h
   ADD v9.8h, v9.8h, v25.8h
   ADD v10.8h, v10.8h, v26.8h
   ADD v11.8h, v11.8h, v27.8h

   //itranspose & store out[0][i+8]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+1*16+2]
   str q29, [x0, #1*128+1*16]

   //[0-7]barrett_fake(out[1][i])
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+2*16+2]
   str q5, [x0, #1*128+2*16]

   //[8-15] mc[6][i] + out[0][i+4]
   //[0-7] arg5 = mc[6][i+4] - mc[7][i];
   //load mc[6][i+4]
   ldr q0, [x4, #0*16+64*13]
   ldr q1, [x4, #1*16+64*13]
   ldr q2, [x4, #2*16+64*13]
   ldr q3, [x4, #3*16+64*13]
   //load mc[7][i]
   ldr q16, [x4, #0*16+64*14]
   ldr q17, [x4, #1*16+64*14]
   ldr q18, [x4, #2*16+64*14]
   ldr q19, [x4, #3*16+64*14]
   SUB v0.8h, v0.8h, v16.8h
   SUB v1.8h, v1.8h, v17.8h
   SUB v2.8h, v2.8h, v18.8h
   SUB v3.8h, v3.8h, v19.8h


   //[24-31] =  out[2][i] - arg2
   //load out[2][i] - arg2 
   ldr q24, [x4, #0*16+64*3]
   ldr q25, [x4, #1*16+64*3]
   ldr q26, [x4, #2*16+64*3]
   ldr q27, [x4, #3*16+64*3]
   //out[2][i] - arg2 - arg5
   SUB v24.8h, v24.8h, v0.8h
   SUB v25.8h, v25.8h, v1.8h
   SUB v26.8h, v26.8h, v2.8h
   SUB v27.8h, v27.8h, v3.8h
   //barrett out[2][i]
   mov      w9,  #4591
   DUP      v19.8H,  w9
   mov      w8, #7
   DUP      v18.8H,  w8
   //SQRDMULH v16.8h, v24.8h,  v18.8h
   //MLS      v24.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v25.8h,  v18.8h
   //MLS      v25.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v26.8h,  v18.8h
   //MLS      v26.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v27.8h,  v18.8h
   //MLS      v27.8h, v16.8h,  v19.8h
   
   //itranspose & store out[2][i]
   trn1 v28.2d, v24.2d, v26.2d
   trn2 v29.2d, v24.2d, v26.2d
   trn1 v30.2d, v25.2d, v27.2d
   trn2 v31.2d, v25.2d, v27.2d

   trn1 v24.4s, v28.4s, v30.4s
   trn1 v26.4s, v29.4s, v31.4s
   trn2 v25.4s, v28.4s, v30.4s
   trn2 v27.4s, v29.4s, v31.4s

   trn1 v28.8h, v24.8h, v26.8h
   trn1 v30.8h, v25.8h, v27.8h
   trn2 v29.8h, v24.8h, v26.8h
   trn2 v31.8h, v25.8h, v27.8h

   add v28.8h, v28.8h, v29.8h
   add v29.8h, v30.8h, v31.8h
   SQRDMULH v16.8h, v28.8h,  v18.8h
   MLS      v28.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v29.8h,  v18.8h
   MLS      v29.8h, v16.8h,  v19.8h
   str q28, [x0, #0*128+4*16+2]
   str q29, [x0, #1*128+4*16]

   //[8-15] mc[6][i] + out[0][i+4]; [0-7] = arg5
   //out[1][i+4] = barrett_fake(arg5 + mc[8][i]   - (arg4 + mc[6][i] + out[0][i+4]));
   //load mc[8][i] 
   ldr q24, [x4, #0*16+64*16]
   ldr q25, [x4, #1*16+64*16]
   ldr q26, [x4, #2*16+64*16]
   ldr q27, [x4, #3*16+64*16]
   ADD v0.8h, v0.8h, v24.8h
   ADD v1.8h, v1.8h, v25.8h
   ADD v2.8h, v2.8h, v26.8h
   ADD v3.8h, v3.8h, v27.8h
   //load arg4
   ldr q24, [x4, #0*16+64*4]
   ldr q25, [x4, #1*16+64*4]
   ldr q26, [x4, #2*16+64*4]
   ldr q27, [x4, #3*16+64*4]
   //(arg4 + mc[6][i] + out[0][i+8])
   ADD v24.8h, v24.8h, v8.8h
   ADD v25.8h, v25.8h, v9.8h
   ADD v26.8h, v26.8h, v10.8h
   ADD v27.8h, v27.8h, v11.8h
   //out[1][i+8]
   SUB v0.8h, v0.8h, v24.8h
   SUB v1.8h, v1.8h, v25.8h
   SUB v2.8h, v2.8h, v26.8h
   SUB v3.8h, v3.8h, v27.8h


   //barrett out[1][i+8]
   //SQRDMULH v16.8h, v0.8h,  v18.8h
   //MLS      v0.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v1.8h,  v18.8h
   //MLS      v1.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v2.8h,  v18.8h
   //MLS      v2.8h, v16.8h,  v19.8h
   //SQRDMULH v16.8h, v3.8h,  v18.8h
   //MLS      v3.8h, v16.8h,  v19.8h
   
   //itranspose & store out[1][i+8]
   trn1 v4.2d, v0.2d, v2.2d
   trn2 v5.2d, v0.2d, v2.2d
   trn1 v6.2d, v1.2d, v3.2d
   trn2 v7.2d, v1.2d, v3.2d

   trn1 v0.4s, v4.4s, v6.4s
   trn1 v2.4s, v5.4s, v7.4s
   trn2 v1.4s, v4.4s, v6.4s
   trn2 v3.4s, v5.4s, v7.4s

   trn1 v4.8h, v0.8h, v2.8h
   trn1 v6.8h, v1.8h, v3.8h
   trn2 v5.8h, v0.8h, v2.8h
   trn2 v7.8h, v1.8h, v3.8h

   add v4.8h, v4.8h, v5.8h
   add v5.8h, v6.8h, v7.8h
   SQRDMULH v16.8h, v4.8h,  v18.8h
   MLS      v4.8h, v16.8h,  v19.8h
   SQRDMULH v16.8h, v5.8h,  v18.8h
   MLS      v5.8h, v16.8h,  v19.8h
   str q4, [x0, #0*128+3*16+2]
   str q5, [x0, #1*128+3*16]

   ret
   