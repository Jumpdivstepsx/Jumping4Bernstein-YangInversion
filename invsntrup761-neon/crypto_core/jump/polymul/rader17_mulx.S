.align 6
.global __rader8x8p_x1
.global ___rader8x8p_x1
.global __rader8x8n_x1
.global ___rader8x8n_x1
.global __rader8x8p_x2
.global ___rader8x8p_x2
.global __rader8x8n_x2
.global ___rader8x8n_x2
.global __rader8x8p_x4
.global ___rader8x8p_x4
.global __rader8x8n_x4
.global ___rader8x8n_x4


// *x in a

__rader8x8p_x1:
___rader8x8p_x1:
   
   //load a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]
   
   //load b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLAL    v14.4S,  v17.4h,  v31.4h
   SMLAL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v30.4h
   SMLAL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v29.4h
   SMLAL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v28.4h
   SMLAL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v27.4h
   SMLAL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v26.4h
   SMLAL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v25.4h
   SMLAL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   // store c[0]
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   // store c[6]
   MLS      v6.8h,  v9.8h,   v11.8h

   //-----------------------------------------
   
   //;c[1] c[13]   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h   
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;c[5] c[9]
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v31.4h
   SMLAL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v30.4h
   SMLAL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v29.4h
   SMLAL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v28.4h
   SMLAL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v27.4h
   SMLAL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v26.4h
   SMLAL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   // store c[1]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h
   // storw c[5]


   //--------------------------------------

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

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v31.4h
   SMLAL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v30.4h
   SMLAL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v29.4h
   SMLAL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v28.4h
   SMLAL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v27.4h
   SMLAL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   // store c[2]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h
   // store c[4]

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v31.4h
   SMLAL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v30.4h
   SMLAL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v29.4h
   SMLAL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v28.4h
   SMLAL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h
   // store c[7]

   // transpose & store c
   STR  q7, [x0, #0*16]
   STR  q0, [x0, #1*16]
   STR  q1, [x0, #2*16]
   STR  q2, [x0, #3*16]
   STR  q3, [x0, #4*16]
   STR  q4, [x0, #5*16]
   STR  q5, [x0, #6*16]
   STR  q6, [x0, #7*16] 
   ret


__rader8x8n_x1:
___rader8x8n_x1:
   
   //load & transpose a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]
   //neg v16.8h, v16.8h


   //load & transpose b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLSL    v14.4S,  v17.4h,  v31.4h
   SMLSL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v30.4h
   SMLSL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v29.4h
   SMLSL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v28.4h
   SMLSL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v27.4h
   SMLSL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v26.4h
   SMLSL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v25.4h
   SMLSL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v6.8h,  v9.8h,   v11.8h
   //-----------------------------------------
   
   //;c[1] v14.15 c[13] v11.12   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[5]v1112+ c[9]v1415-
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v31.4h
   SMLSL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v30.4h
   SMLSL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v29.4h
   SMLSL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v28.4h
   SMLSL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v27.4h
   SMLSL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v26.4h
   SMLSL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h


   //--------------------------------------

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
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v31.4h
   SMLSL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v30.4h
   SMLSL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v29.4h
   SMLSL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v28.4h
   SMLSL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v27.4h
   SMLSL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v31.4h
   SMLSL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v30.4h
   SMLSL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v29.4h
   SMLSL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v28.4h
   SMLSL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h

   neg v7.8h, v7.8h
   STR  q7, [x0, #0*16]
   STR  q0, [x0, #1*16]
   STR  q1, [x0, #2*16]
   STR  q2, [x0, #3*16]
   STR  q3, [x0, #4*16]
   STR  q4, [x0, #5*16]
   STR  q5, [x0, #6*16]
   STR  q6, [x0, #7*16]
   ret


__rader8x8p_x2:
___rader8x8p_x2:
   
   //load a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]
   
   //load b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLAL    v14.4S,  v17.4h,  v31.4h
   SMLAL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v30.4h
   SMLAL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v29.4h
   SMLAL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v28.4h
   SMLAL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v27.4h
   SMLAL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v26.4h
   SMLAL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v25.4h
   SMLAL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   // store c[0]
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   // store c[6]
   MLS      v6.8h,  v9.8h,   v11.8h

   //-----------------------------------------
   
   //;c[1] c[13]   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h   
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;c[5] c[9]
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v31.4h
   SMLAL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v30.4h
   SMLAL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v29.4h
   SMLAL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v28.4h
   SMLAL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v27.4h
   SMLAL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v26.4h
   SMLAL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   // store c[1]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h
   // storw c[5]


   //--------------------------------------

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

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v31.4h
   SMLAL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v30.4h
   SMLAL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v29.4h
   SMLAL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v28.4h
   SMLAL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v27.4h
   SMLAL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   // store c[2]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h
   // store c[4]

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v31.4h
   SMLAL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v30.4h
   SMLAL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v29.4h
   SMLAL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v28.4h
   SMLAL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h
   // store c[7]

   // transpose & store c
   STR  q6, [x0, #0*16] 
   STR  q7, [x0, #1*16]
   STR  q0, [x0, #2*16]
   STR  q1, [x0, #3*16]
   STR  q2, [x0, #4*16]
   STR  q3, [x0, #5*16]
   STR  q4, [x0, #6*16]
   STR  q5, [x0, #7*16]
   ret


__rader8x8n_x2:
___rader8x8n_x2:
   
   //load & transpose a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]


   //load & transpose b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLSL    v14.4S,  v17.4h,  v31.4h
   SMLSL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v30.4h
   SMLSL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v29.4h
   SMLSL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v28.4h
   SMLSL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v27.4h
   SMLSL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v26.4h
   SMLSL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v25.4h
   SMLSL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v6.8h,  v9.8h,   v11.8h
   //-----------------------------------------
   
   //;c[1] v14.15 c[13] v11.12   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[5]v1112+ c[9]v1415-
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v31.4h
   SMLSL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v30.4h
   SMLSL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v29.4h
   SMLSL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v28.4h
   SMLSL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v27.4h
   SMLSL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v26.4h
   SMLSL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h


   //--------------------------------------

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
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v31.4h
   SMLSL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v30.4h
   SMLSL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v29.4h
   SMLSL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v28.4h
   SMLSL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v27.4h
   SMLSL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v31.4h
   SMLSL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v30.4h
   SMLSL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v29.4h
   SMLSL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v28.4h
   SMLSL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h

   neg v7.8h, v7.8h
   neg v6.8h, v6.8h
   STR  q6, [x0, #0*16]
   STR  q7, [x0, #1*16]
   STR  q0, [x0, #2*16]
   STR  q1, [x0, #3*16]
   STR  q2, [x0, #4*16]
   STR  q3, [x0, #5*16]
   STR  q4, [x0, #6*16]
   STR  q5, [x0, #7*16]
   ret


__rader8x8p_x4:
___rader8x8p_x4:
   
   //load a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]
   
   //load b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLAL    v14.4S,  v17.4h,  v31.4h
   SMLAL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v30.4h
   SMLAL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v29.4h
   SMLAL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v28.4h
   SMLAL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v27.4h
   SMLAL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v26.4h
   SMLAL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v25.4h
   SMLAL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   // store c[0]
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   // store c[6]
   MLS      v6.8h,  v9.8h,   v11.8h

   //-----------------------------------------
   
   //;c[1] c[13]   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h   
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h

   //;c[5] c[9]
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLAL    v14.4S,  v18.4h,  v31.4h
   SMLAL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v30.4h
   SMLAL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v29.4h
   SMLAL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v28.4h
   SMLAL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v27.4h
   SMLAL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v26.4h
   SMLAL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   // store c[1]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h
   // storw c[5]


   //--------------------------------------

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

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLAL    v14.4S,  v19.4h,  v31.4h
   SMLAL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v30.4h
   SMLAL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v29.4h
   SMLAL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v28.4h
   SMLAL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v27.4h
   SMLAL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   // store c[2]
   SQRDMULH v12.4S,  v12.4S,  v8.4S

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h
   // store c[4]

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLAL    v14.4S,  v20.4h,  v31.4h
   SMLAL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLAL    v14.4S,  v21.4h,  v30.4h
   SMLAL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLAL    v14.4S,  v22.4h,  v29.4h
   SMLAL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLAL    v14.4S,  v23.4h,  v28.4h
   SMLAL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h
   // store c[7]

   // store c * x^4
   STR  q4, [x0, #0*16]
   STR  q5, [x0, #1*16]
   STR  q6, [x0, #2*16]
   STR  q7, [x0, #3*16]
   STR  q0, [x0, #4*16]
   STR  q1, [x0, #5*16]
   STR  q2, [x0, #6*16]
   STR  q3, [x0, #7*16]
   ret


__rader8x8n_x4:
___rader8x8n_x4:
   
   //load & transpose a
   ldr q16, [x1, #0*16]
   ldr q17, [x1, #1*16]
   ldr q18, [x1, #2*16]
   ldr q19, [x1, #3*16]
   ldr q20, [x1, #4*16]
   ldr q21, [x1, #5*16]
   ldr q22, [x1, #6*16]
   ldr q23, [x1, #7*16]
   //neg v16.8h, v16.8h


   //load & transpose b
   ldr q24, [x2, #0*16]
   ldr q25, [x2, #1*16]
   ldr q26, [x2, #2*16]
   ldr q27, [x2, #3*16]
   ldr q28, [x2, #4*16]
   ldr q29, [x2, #5*16]
   ldr q30, [x2, #6*16]
   ldr q31, [x2, #7*16]

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7
    
   // v14.v15 || v11.v12

   // c[0] c[14]
   SMULL    v14.4S,  v16.4h,  v24.4h   
   SMULL2   v15.4S,  v16.8h,  v24.8h
   SMULL    v11.4S,  v23.4h,  v31.4h
   SMULL2   v12.4S,  v23.8h,  v31.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v30.4h
   SMLAL2   v12.4S,  v16.8h,  v30.8h
   SMLSL    v14.4S,  v17.4h,  v31.4h
   SMLSL2   v15.4S,  v17.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v29.4h
   SMLAL2   v12.4S,  v17.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v30.4h
   SMLSL2   v15.4S,  v18.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v28.4h
   SMLAL2   v12.4S,  v18.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v29.4h
   SMLSL2   v15.4S,  v19.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v27.4h
   SMLAL2   v12.4S,  v19.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v28.4h
   SMLSL2   v15.4S,  v20.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v26.4h
   SMLAL2   v12.4S,  v20.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v27.4h
   SMLSL2   v15.4S,  v21.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v25.4h
   SMLAL2   v12.4S,  v21.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v26.4h
   SMLSL2   v15.4S,  v22.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v24.4h
   SMLAL2   v12.4S,  v22.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v25.4h
   SMLSL2   v15.4S,  v23.8h,  v25.8h

   // barrett [0][6]
   UZP1     v0.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v6.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v0.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v6.8h,  v9.8h,   v11.8h
   //-----------------------------------------
   
   //;c[1] v14.15 c[13] v11.12   
   SMULL    v14.4S,  v16.4h,  v25.4h   
   SMULL2   v15.4S,  v16.8h,  v25.8h   
   SMULL    v11.4S,  v22.4h,  v31.4h   
   SMULL2   v12.4S,  v22.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v24.4h   
   SMLAL2   v15.4S,  v17.8h,  v24.8h   
   SMLAL    v11.4S,  v23.4h,  v30.4h   
   SMLAL2   v12.4S,  v23.8h,  v30.8h
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[5]v1112+ c[9]v1415-
   SMLAL    v11.4S,  v16.4h,  v29.4h
   SMLAL2   v12.4S,  v16.8h,  v29.8h
   SMLSL    v14.4S,  v18.4h,  v31.4h
   SMLSL2   v15.4S,  v18.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v28.4h
   SMLAL2   v12.4S,  v17.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v30.4h
   SMLSL2   v15.4S,  v19.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v27.4h
   SMLAL2   v12.4S,  v18.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v29.4h
   SMLSL2   v15.4S,  v20.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v26.4h
   SMLAL2   v12.4S,  v19.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v28.4h
   SMLSL2   v15.4S,  v21.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v25.4h
   SMLAL2   v12.4S,  v20.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v27.4h
   SMLSL2   v15.4S,  v22.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v24.4h
   SMLAL2   v12.4S,  v21.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v26.4h
   SMLSL2   v15.4S,  v23.8h,  v26.8h

   //;barrett [1][5]
   UZP1     v1.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v5.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v1.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v5.8h,  v9.8h,   v11.8h


   //--------------------------------------

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
   NEG     v11.4S,   v11.4S
   NEG     v12.4S,   v12.4S

   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v28.4h
   SMLAL2   v12.4S,  v16.8h,  v28.8h
   SMLSL    v14.4S,  v19.4h,  v31.4h
   SMLSL2   v15.4S,  v19.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v27.4h
   SMLAL2   v12.4S,  v17.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v30.4h
   SMLSL2   v15.4S,  v20.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v26.4h
   SMLAL2   v12.4S,  v18.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v29.4h
   SMLSL2   v15.4S,  v21.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v25.4h
   SMLAL2   v12.4S,  v19.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v28.4h
   SMLSL2   v15.4S,  v22.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v24.4h
   SMLAL2   v12.4S,  v20.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v27.4h
   SMLSL2   v15.4S,  v23.8h,  v27.8h

   //;barrett[2][4]
   UZP1     v2.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v4.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v2.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v4.8h,  v9.8h,   v11.8h

   //----------------------------------------

   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v27.4h
   SMULL2   v15.4S,  v16.8h,  v27.8h
   SMLSL    v14.4S,  v20.4h,  v31.4h
   SMLSL2   v15.4S,  v20.8h,  v31.8h
   SMLAL    v14.4S,  v17.4h,  v26.4h
   SMLAL2   v15.4S,  v17.8h,  v26.8h
   SMLSL    v14.4S,  v21.4h,  v30.4h
   SMLSL2   v15.4S,  v21.8h,  v30.8h
   SMLAL    v14.4S,  v18.4h,  v25.4h
   SMLAL2   v15.4S,  v18.8h,  v25.8h
   SMLSL    v14.4S,  v22.4h,  v29.4h
   SMLSL2   v15.4S,  v22.8h,  v29.8h
   SMLAL    v14.4S,  v19.4h,  v24.4h
   SMLAL2   v15.4S,  v19.8h,  v24.8h
   SMLSL    v14.4S,  v23.4h,  v28.4h
   SMLSL2   v15.4S,  v23.8h,  v28.8h

   //;c[7]
   SMULL    v11.4S,  v16.4h,  v31.4h
   SMULL2   v12.4S,  v16.8h,  v31.8h
   SMLAL    v11.4S,  v17.4h,  v30.4h
   SMLAL2   v12.4S,  v17.8h,  v30.8h
   SMLAL    v11.4S,  v18.4h,  v29.4h
   SMLAL2   v12.4S,  v18.8h,  v29.8h
   SMLAL    v11.4S,  v19.4h,  v28.4h
   SMLAL2   v12.4S,  v19.8h,  v28.8h
   SMLAL    v11.4S,  v20.4h,  v27.4h
   SMLAL2   v12.4S,  v20.8h,  v27.8h
   SMLAL    v11.4S,  v21.4h,  v26.4h
   SMLAL2   v12.4S,  v21.8h,  v26.8h
   SMLAL    v11.4S,  v22.4h,  v25.4h
   SMLAL2   v12.4S,  v22.8h,  v25.8h
   SMLAL    v11.4S,  v23.4h,  v24.4h
   SMLAL2   v12.4S,  v23.8h,  v24.8h

   //;barrett[3][7]
   UZP1     v3.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S   
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   MLS      v3.8h,  v9.8h,   v14.8h
   
   UZP1     v7.8h,  v11.8h,  v12.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S   
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v7.8h,  v9.8h,   v11.8h

   neg v4.8h, v4.8h
   neg v5.8h, v5.8h
   neg v6.8h, v6.8h
   neg v7.8h, v7.8h
   STR  q4, [x0, #0*16]
   STR  q5, [x0, #1*16]
   STR  q6, [x0, #2*16]
   STR  q7, [x0, #3*16]
   STR  q0, [x0, #4*16]
   STR  q1, [x0, #5*16]
   STR  q2, [x0, #6*16]
   STR  q3, [x0, #7*16]
   ret