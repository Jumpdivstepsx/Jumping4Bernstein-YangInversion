.align 6
.global __truncated_rader17_768
.global ___truncated_rader17_768
.global __itruncated_rader_17_768
.global ___itruncated_rader_17_768

__truncated_rader17_768:
___truncated_rader17_768:
   //0, 14, 1, 12, 5, 15, 11, 10, 2, 3, 7, 13, 4, 9, 6, 8
   //(16 - rader_dlog_permute[i]) % 16 = src[i]
   // low
   ldr q0, [x1, #0*96]
   ldr q1, [x1, #5*96]
   ldr q2, [x1, #1*96]
   ldr q3, [x1, #11*96]
   ldr q4, [x1, #3*96]
   ldr q5, [x1, #6*96]
   ldr q6, [x1, #7*96]
   ldr q7, [x1, #13*96]
   // high
   ldr q8, [x1, #15*96]
   ldr q9, [x1, #10*96]
   ldr q10, [x1, #14*96]
   ldr q11, [x1, #4*96]
   ldr q12, [x1, #12*96]
   ldr q13, [x1, #9*96]
   ldr q14, [x1, #8*96]
   ldr q15, [x1, #2*96]
   
   //(x^8-1)
   ADD v16.8h, v0.8h, v8.8H
   SUB v24.8h, v0.8h, v8.8H
   ADD v17.8h, v1.8h, v9.8H
   SUB v25.8h, v1.8h, v9.8H
   ADD v18.8h, v2.8h, v10.8H
   SUB v26.8h, v2.8h, v10.8H
   ADD v19.8h, v3.8h, v11.8H
   SUB v27.8h, v3.8h, v11.8H
   ADD v20.8h, v4.8h, v12.8H
   SUB v28.8h, v4.8h, v12.8H
   ADD v21.8h, v5.8h, v13.8H
   SUB v29.8h, v5.8h, v13.8H
   ADD v22.8h, v6.8h, v14.8H
   SUB v30.8h, v6.8h, v14.8H
   ADD v23.8h, v7.8h, v15.8H
   SUB v31.8h, v7.8h, v15.8H

   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   mov      w5,  #4591
   DUP      v9.8H,  w5
   DUP      v8.4S,  w7

   //For v16-23 (x^8-1)
   ldr q3, [x2, #0*16]
   //For v24-31 (x^8+1)
   ldr q4, [x3, #0*16]

   // c[0] c[14] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v3.8h[0]
   SMULL2   v15.4S,  v16.8h,  v3.8h[0]
   SMULL    v11.4S,  v23.4h,  v3.4h[7]
   SMULL2   v12.4S,  v23.8h,  v3.8h[7]
   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v3.4h[6]
   SMLAL2   v12.4S,  v16.8h,  v3.8h[6]
   SMLAL    v14.4S,  v17.4h,  v3.4h[7]
   SMLAL2   v15.4S,  v17.8h,  v3.8h[7]
   SMLAL    v11.4S,  v17.4h,  v3.4h[5]
   SMLAL2   v12.4S,  v17.8h,  v3.8h[5]
   SMLAL    v14.4S,  v18.4h,  v3.4h[6]
   SMLAL2   v15.4S,  v18.8h,  v3.8h[6]
   SMLAL    v11.4S,  v18.4h,  v3.4h[4]
   SMLAL2   v12.4S,  v18.8h,  v3.8h[4]
   SMLAL    v14.4S,  v19.4h,  v3.4h[5]
   SMLAL2   v15.4S,  v19.8h,  v3.8h[5]
   SMLAL    v11.4S,  v19.4h,  v3.4h[3]
   SMLAL2   v12.4S,  v19.8h,  v3.8h[3]
   SMLAL    v14.4S,  v20.4h,  v3.4h[4]
   SMLAL2   v15.4S,  v20.8h,  v3.8h[4]
   SMLAL    v11.4S,  v20.4h,  v3.4h[2]
   SMLAL2   v12.4S,  v20.8h,  v3.8h[2]
   SMLAL    v14.4S,  v21.4h,  v3.4h[3]
   SMLAL2   v15.4S,  v21.8h,  v3.8h[3]
   SMLAL    v11.4S,  v21.4h,  v3.4h[1]
   SMLAL2   v12.4S,  v21.8h,  v3.8h[1]
   SMLAL    v14.4S,  v22.4h,  v3.4h[2]
   SMLAL2   v15.4S,  v22.8h,  v3.8h[2]
   SMLAL    v11.4S,  v22.4h,  v3.4h[0]
   SMLAL2   v12.4S,  v22.8h,  v3.8h[0]
   SMLAL    v14.4S,  v23.4h,  v3.4h[1]
   SMLAL2   v15.4S,  v23.8h,  v3.8h[1]   

   // c[0] c[14] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v4.4h[0]
   SMULL2   v1.4S,  v24.8h,  v4.8h[0]
   SMULL    v6.4S,  v31.4h,  v4.4h[7]
   SMULL2   v7.4S,  v31.8h,  v4.8h[7]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   // c[6] c[8]
   SMLAL    v6.4S,  v24.4h,  v4.4h[6]
   SMLAL2   v7.4S,  v24.8h,  v4.8h[6]
   SMLSL    v0.4S,  v25.4h,  v4.4h[7]
   SMLSL2   v1.4S,  v25.8h,  v4.8h[7]
   SMLAL    v6.4S,  v25.4h,  v4.4h[5]
   SMLAL2   v7.4S,  v25.8h,  v4.8h[5]
   SMLSL    v0.4S,  v26.4h,  v4.4h[6]
   SMLSL2   v1.4S,  v26.8h,  v4.8h[6]
   SMLAL    v6.4S,  v26.4h,  v4.4h[4]
   SMLAL2   v7.4S,  v26.8h,  v4.8h[4]
   SMLSL    v0.4S,  v27.4h,  v4.4h[5]
   SMLSL2   v1.4S,  v27.8h,  v4.8h[5]
   SMLAL    v6.4S,  v27.4h,  v4.4h[3]
   SMLAL2   v7.4S,  v27.8h,  v4.8h[3]
   SMLSL    v0.4S,  v28.4h,  v4.4h[4]
   SMLSL2   v1.4S,  v28.8h,  v4.8h[4]
   SMLAL    v6.4S,  v28.4h,  v4.4h[2]
   SMLAL2   v7.4S,  v28.8h,  v4.8h[2]
   SMLSL    v0.4S,  v29.4h,  v4.4h[3]
   SMLSL2   v1.4S,  v29.8h,  v4.8h[3]
   SMLAL    v6.4S,  v29.4h,  v4.4h[1]
   SMLAL2   v7.4S,  v29.8h,  v4.8h[1]
   SMLSL    v0.4S,  v30.4h,  v4.4h[2]
   SMLSL2   v1.4S,  v30.8h,  v4.8h[2]
   SMLAL    v6.4S,  v30.4h,  v4.4h[0]
   SMLAL2   v7.4S,  v30.8h,  v4.8h[0]
   SMLSL    v0.4S,  v31.4h,  v4.4h[1]
   SMLSL2   v1.4S,  v31.8h,  v4.8h[1]

   // GS-butterfly
   //  5: p0 low   14+0
   // 14: n0 low   14-0
   //  0: p0 high  15+1
   // 15: n0 high  15-1 
   //  1: p6 low   11+6
   // 11: n6 low   11-6
   //  6: p6 high  12+7
   // 12: n6 high  12-7
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S
   
   // barrett [0][6]p low :05 16
   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   //twist with barreet_mul
   ldr q2, [x4, #0*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #0*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #0*16]

   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   ldr q2, [x4, #84*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #84*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #84*16]

   // barrett [0][6]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   //twist with barrett_mul
   ldr q2, [x4, #90*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #90*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #90*16]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   ldr q2, [x4, #6*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #6*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #6*16]

   //;c[1] c[13] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v3.4h[1]   
   SMULL2   v15.4S,  v16.8h,  v3.8h[1]   
   SMULL    v11.4S,  v22.4h,  v3.4h[7]
   SMULL2   v12.4S,  v22.8h,  v3.8h[7]
   SMLAL    v14.4S,  v17.4h,  v3.4h[0]
   SMLAL2   v15.4S,  v17.8h,  v3.8h[0]
   SMLAL    v11.4S,  v23.4h,  v3.4h[6]
   SMLAL2   v12.4S,  v23.8h,  v3.8h[6]
   //;c[5] c[9]
   SMLAL    v11.4S,  v16.4h,  v3.4h[5]
   SMLAL2   v12.4S,  v16.8h,  v3.8h[5]
   SMLAL    v14.4S,  v18.4h,  v3.4h[7]
   SMLAL2   v15.4S,  v18.8h,  v3.8h[7]
   SMLAL    v11.4S,  v17.4h,  v3.4h[4]
   SMLAL2   v12.4S,  v17.8h,  v3.8h[4]
   SMLAL    v14.4S,  v19.4h,  v3.4h[6]
   SMLAL2   v15.4S,  v19.8h,  v3.8h[6]
   SMLAL    v11.4S,  v18.4h,  v3.4h[3]
   SMLAL2   v12.4S,  v18.8h,  v3.8h[3]
   SMLAL    v14.4S,  v20.4h,  v3.4h[5]
   SMLAL2   v15.4S,  v20.8h,  v3.8h[5]
   SMLAL    v11.4S,  v19.4h,  v3.4h[2]
   SMLAL2   v12.4S,  v19.8h,  v3.8h[2]
   SMLAL    v14.4S,  v21.4h,  v3.4h[4]
   SMLAL2   v15.4S,  v21.8h,  v3.8h[4]
   SMLAL    v11.4S,  v20.4h,  v3.4h[1]
   SMLAL2   v12.4S,  v20.8h,  v3.8h[1]
   SMLAL    v14.4S,  v22.4h,  v3.4h[3]
   SMLAL2   v15.4S,  v22.8h,  v3.8h[3]
   SMLAL    v11.4S,  v21.4h,  v3.4h[0]
   SMLAL2   v12.4S,  v21.8h,  v3.8h[0]
   SMLAL    v14.4S,  v23.4h,  v3.4h[2]
   SMLAL2   v15.4S,  v23.8h,  v3.8h[2]

   //;c[1] c[13] for (x^8+1) 
   SMULL    v0.4S,  v24.4h,  v4.4h[1]   
   SMULL2   v1.4S,  v24.8h,  v4.8h[1]   
   SMULL    v6.4S,  v30.4h,  v4.4h[7]
   SMULL2   v7.4S,  v30.8h,  v4.8h[7]
   SMLAL    v0.4S,  v25.4h,  v4.4h[0]
   SMLAL2   v1.4S,  v25.8h,  v4.8h[0]
   SMLAL    v6.4S,  v31.4h,  v4.4h[6]
   SMLAL2   v7.4S,  v31.8h,  v4.8h[6]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   //;c[5] c[9]
   SMLAL    v6.4S,  v24.4h,  v4.4h[5]
   SMLAL2   v7.4S,  v24.8h,  v4.8h[5]
   SMLSL    v0.4S,  v26.4h,  v4.4h[7]
   SMLSL2   v1.4S,  v26.8h,  v4.8h[7]
   SMLAL    v6.4S,  v25.4h,  v4.4h[4]
   SMLAL2   v7.4S,  v25.8h,  v4.8h[4]
   SMLSL    v0.4S,  v27.4h,  v4.4h[6]
   SMLSL2   v1.4S,  v27.8h,  v4.8h[6]
   SMLAL    v6.4S,  v26.4h,  v4.4h[3]
   SMLAL2   v7.4S,  v26.8h,  v4.8h[3]
   SMLSL    v0.4S,  v28.4h,  v4.4h[5]
   SMLSL2   v1.4S,  v28.8h,  v4.8h[5]
   SMLAL    v6.4S,  v27.4h,  v4.4h[2]
   SMLAL2   v7.4S,  v27.8h,  v4.8h[2]
   SMLSL    v0.4S,  v29.4h,  v4.4h[4]
   SMLSL2   v1.4S,  v29.8h,  v4.8h[4]
   SMLAL    v6.4S,  v28.4h,  v4.4h[1]
   SMLAL2   v7.4S,  v28.8h,  v4.8h[1]
   SMLSL    v0.4S,  v30.4h,  v4.4h[3]
   SMLSL2   v1.4S,  v30.8h,  v4.8h[3]
   SMLAL    v6.4S,  v29.4h,  v4.4h[0]
   SMLAL2   v7.4S,  v29.8h,  v4.8h[0]
   SMLSL    v0.4S,  v31.4h,  v4.4h[2]
   SMLSL2   v1.4S,  v31.8h,  v4.8h[2]

   //;barrett [1][5]p
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S

   ldr q2, [x4, #12*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #12*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #12*16]
   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   ldr q2, [x4, #24*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #24*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #24*16]

   // barrett [1][5]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   ldr q2, [x4, #78*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #78*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #78*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   ldr q2, [x4, #66*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #66*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #66*16]


   //;c[2] c[12] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v3.h[2]
   SMULL2   v15.4S,  v16.8h,  v3.8h[2]
   SMULL    v11.4S,  v21.4h,  v3.4h[7]
   SMULL2   v12.4S,  v21.8h,  v3.8h[7]
   SMLAL    v14.4S,  v17.4h,  v3.4h[1]
   SMLAL2   v15.4S,  v17.8h,  v3.8h[1]
   SMLAL    v11.4S,  v22.4h,  v3.4h[6]
   SMLAL2   v12.4S,  v22.8h,  v3.8h[6]
   SMLAL    v14.4S,  v18.4h,  v3.4h[0]
   SMLAL2   v15.4S,  v18.8h,  v3.8h[0]
   SMLAL    v11.4S,  v23.4h,  v3.4h[5]
   SMLAL2   v12.4S,  v23.8h,  v3.8h[5]
   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v3.4h[4]
   SMLAL2   v12.4S,  v16.8h,  v3.8h[4]
   SMLAL    v14.4S,  v19.4h,  v3.4h[7]
   SMLAL2   v15.4S,  v19.8h,  v3.8h[7]
   SMLAL    v11.4S,  v17.4h,  v3.4h[3]
   SMLAL2   v12.4S,  v17.8h,  v3.8h[3]
   SMLAL    v14.4S,  v20.4h,  v3.4h[6]
   SMLAL2   v15.4S,  v20.8h,  v3.8h[6]
   SMLAL    v11.4S,  v18.4h,  v3.4h[2]
   SMLAL2   v12.4S,  v18.8h,  v3.8h[2]
   SMLAL    v14.4S,  v21.4h,  v3.4h[5]
   SMLAL2   v15.4S,  v21.8h,  v3.8h[5]
   SMLAL    v11.4S,  v19.4h,  v3.4h[1]
   SMLAL2   v12.4S,  v19.8h,  v3.8h[1]
   SMLAL    v14.4S,  v22.4h,  v3.4h[4]
   SMLAL2   v15.4S,  v22.8h,  v3.8h[4]
   SMLAL    v11.4S,  v20.4h,  v3.4h[0]
   SMLAL2   v12.4S,  v20.8h,  v3.8h[0]
   SMLAL    v14.4S,  v23.4h,  v3.4h[3]
   SMLAL2   v15.4S,  v23.8h,  v3.8h[3]

   //;c[2] c[12] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v4.4h[2]
   SMULL2   v1.4S,  v24.8h,  v4.8h[2]
   SMULL    v6.4S,  v29.4h,  v4.4h[7]
   SMULL2   v7.4S,  v29.8h,  v4.8h[7]
   SMLAL    v0.4S,  v25.4h,  v4.4h[1]
   SMLAL2   v1.4S,  v25.8h,  v4.8h[1]
   SMLAL    v6.4S,  v30.4h,  v4.4h[6]
   SMLAL2   v7.4S,  v30.8h,  v4.8h[6]
   SMLAL    v0.4S,  v26.4h,  v4.4h[0]
   SMLAL2   v1.4S,  v26.8h,  v4.8h[0]
   SMLAL    v6.4S,  v31.4h,  v4.4h[5]
   SMLAL2   v7.4S,  v31.8h,  v4.8h[5]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   //;c[4] c[10]
   SMLAL    v6.4S,  v24.4h,  v4.4h[4]
   SMLAL2   v7.4S,  v24.8h,  v4.8h[4]
   SMLSL    v0.4S,  v27.4h,  v4.4h[7]
   SMLSL2   v1.4S,  v27.8h,  v4.8h[7]
   SMLAL    v6.4S,  v25.4h,  v4.4h[3]
   SMLAL2   v7.4S,  v25.8h,  v4.8h[3]
   SMLSL    v0.4S,  v28.4h,  v4.4h[6]
   SMLSL2   v1.4S,  v28.8h,  v4.8h[6]
   SMLAL    v6.4S,  v26.4h,  v4.4h[2]
   SMLAL2   v7.4S,  v26.8h,  v4.8h[2]
   SMLSL    v0.4S,  v29.4h,  v4.4h[5]
   SMLSL2   v1.4S,  v29.8h,  v4.8h[5]
   SMLAL    v6.4S,  v27.4h,  v4.4h[1]
   SMLAL2   v7.4S,  v27.8h,  v4.8h[1]
   SMLSL    v0.4S,  v30.4h,  v4.4h[4]
   SMLSL2   v1.4S,  v30.8h,  v4.8h[4]
   SMLAL    v6.4S,  v28.4h,  v4.4h[0]
   SMLAL2   v7.4S,  v28.8h,  v4.8h[0]
   SMLSL    v0.4S,  v31.4h,  v4.4h[3]
   SMLSL2   v1.4S,  v31.8h,  v4.8h[3]

   //;barrett [2][4]p
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   ldr q2, [x4, #48*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #48*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #48*16]

   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   ldr q2, [x4, #72*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #72*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #72*16]
   
   // barrett [2][4]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   ldr q2, [x4, #42*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #42*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #42*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   ldr q2, [x4, #18*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #18*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #18*16]

   //;c[3] c[11] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v3.4h[3]
   SMULL2   v15.4S,  v16.8h,  v3.8h[3]
   SMLAL    v14.4S,  v20.4h,  v3.4h[7]
   SMLAL2   v15.4S,  v20.8h,  v3.8h[7]
   SMLAL    v14.4S,  v17.4h,  v3.4h[2]
   SMLAL2   v15.4S,  v17.8h,  v3.8h[2]
   SMLAL    v14.4S,  v21.4h,  v3.4h[6]
   SMLAL2   v15.4S,  v21.8h,  v3.8h[6]
   SMLAL    v14.4S,  v18.4h,  v3.4h[1]
   SMLAL2   v15.4S,  v18.8h,  v3.8h[1]
   SMLAL    v14.4S,  v22.4h,  v3.4h[5]
   SMLAL2   v15.4S,  v22.8h,  v3.8h[5]
   SMLAL    v14.4S,  v19.4h,  v3.4h[0]
   SMLAL2   v15.4S,  v19.8h,  v3.8h[0]
   SMLAL    v14.4S,  v23.4h,  v3.4h[4]
   SMLAL2   v15.4S,  v23.8h,  v3.8h[4]
   //;c[7]
   SMULL    v11.4S,  v16.4h,  v3.4h[7]
   SMULL2   v12.4S,  v16.8h,  v3.8h[7]
   SMLAL    v11.4S,  v17.4h,  v3.4h[6]
   SMLAL2   v12.4S,  v17.8h,  v3.8h[6]
   SMLAL    v11.4S,  v18.4h,  v3.4h[5]
   SMLAL2   v12.4S,  v18.8h,  v3.8h[5]
   SMLAL    v11.4S,  v19.4h,  v3.4h[4]
   SMLAL2   v12.4S,  v19.8h,  v3.8h[4]
   SMLAL    v11.4S,  v20.4h,  v3.4h[3]
   SMLAL2   v12.4S,  v20.8h,  v3.8h[3]
   SMLAL    v11.4S,  v21.4h,  v3.4h[2]
   SMLAL2   v12.4S,  v21.8h,  v3.8h[2]
   SMLAL    v11.4S,  v22.4h,  v3.4h[1]
   SMLAL2   v12.4S,  v22.8h,  v3.8h[1]
   SMLAL    v11.4S,  v23.4h,  v3.4h[0]
   SMLAL2   v12.4S,  v23.8h,  v3.8h[0]
   
   //;c[3] c[11] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v4.4h[3]
   SMULL2   v1.4S,  v24.8h,  v4.8h[3]
   SMLSL    v0.4S,  v28.4h,  v4.4h[7]
   SMLSL2   v1.4S,  v28.8h,  v4.8h[7]
   SMLAL    v0.4S,  v25.4h,  v4.4h[2]
   SMLAL2   v1.4S,  v25.8h,  v4.8h[2]
   SMLSL    v0.4S,  v29.4h,  v4.4h[6]
   SMLSL2   v1.4S,  v29.8h,  v4.8h[6]
   SMLAL    v0.4S,  v26.4h,  v4.4h[1]
   SMLAL2   v1.4S,  v26.8h,  v4.8h[1]
   SMLSL    v0.4S,  v30.4h,  v4.4h[5]
   SMLSL2   v1.4S,  v30.8h,  v4.8h[5]
   SMLAL    v0.4S,  v27.4h,  v4.4h[0]
   SMLAL2   v1.4S,  v27.8h,  v4.8h[0]
   SMLSL    v0.4S,  v31.4h,  v4.4h[4]
   SMLSL2   v1.4S,  v31.8h,  v4.8h[4]
   //;c[7]
   SMULL    v6.4S,  v24.4h,  v4.4h[7]
   SMULL2   v7.4S,  v24.8h,  v4.8h[7]
   SMLAL    v6.4S,  v25.4h,  v4.4h[6]
   SMLAL2   v7.4S,  v25.8h,  v4.8h[6]
   SMLAL    v6.4S,  v26.4h,  v4.4h[5]
   SMLAL2   v7.4S,  v26.8h,  v4.8h[5]
   SMLAL    v6.4S,  v27.4h,  v4.4h[4]
   SMLAL2   v7.4S,  v27.8h,  v4.8h[4]
   SMLAL    v6.4S,  v28.4h,  v4.4h[3]
   SMLAL2   v7.4S,  v28.8h,  v4.8h[3]
   SMLAL    v6.4S,  v29.4h,  v4.4h[2]
   SMLAL2   v7.4S,  v29.8h,  v4.8h[2]
   SMLAL    v6.4S,  v30.4h,  v4.4h[1]
   SMLAL2   v7.4S,  v30.8h,  v4.8h[1]
   SMLAL    v6.4S,  v31.4h,  v4.4h[0]
   SMLAL2   v7.4S,  v31.8h,  v4.8h[0]

   //  5: p3 low
   // 14: n3 low 
   //  0: p3 high
   // 15: n3 high
   //  1: p7 low
   // 11: n7 low
   //  6: p7 high
   // 12: n7 high 
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   //;barrett[3][7]p
   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   ldr q2, [x4, #54*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #54*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #54*16]

   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   ldr q2, [x4, #60*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #60*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #60*16]

   // barrett [3][7]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   ldr q2, [x4, #36*16+1536]
   SQRDMULH v0.8h, v13.8h, v2.8h
   ldr q2, [x4, #36*16]
   MUL   v5.8h, v13.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #36*16]

   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   ldr q2, [x4, #30*16+1536]
   SQRDMULH v0.8h, v10.8h, v2.8h
   ldr q2, [x4, #30*16]
   MUL   v5.8h, v10.8h, v2.8h
   MLS   v5.8h, v0.8h, v9.8h
   STR      q5,     [x0, #30*16]
   ret

__itruncated_rader_17_768:
___itruncated_rader_17_768:
   mov      w5,  #4591
   DUP      v9.8H,  w5

   // 0
   ldr q4, [x1, #0*16]
   ldr q3, [x4, #0*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #0*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 1
   ldr q4, [x1, #90*16]
   ldr q3, [x4, #90*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #90*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v16.8h, v0.8h, v1.8h
   sub   v24.8h, v0.8h, v1.8h

   // 2
   ldr q4, [x1, #12*16]
   ldr q3, [x4, #12*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #12*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 3
   ldr q4, [x1, #78*16]
   ldr q3, [x4, #78*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #78*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v17.8h, v0.8h, v1.8h
   sub   v25.8h, v0.8h, v1.8h

   // 4
   ldr q4, [x1, #48*16]
   ldr q3, [x4, #48*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #48*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 5
   ldr q4, [x1, #42*16]
   ldr q3, [x4, #42*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #42*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v18.8h, v0.8h, v1.8h
   sub   v26.8h, v0.8h, v1.8h

   // 6
   ldr q4, [x1, #54*16]
   ldr q3, [x4, #54*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #54*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 7
   ldr q4, [x1, #36*16]
   ldr q3, [x4, #36*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #36*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v19.8h, v0.8h, v1.8h
   sub   v27.8h, v0.8h, v1.8h

   // 8
   ldr q4, [x1, #72*16]
   ldr q3, [x4, #72*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #72*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 9
   ldr q4, [x1, #18*16]
   ldr q3, [x4, #18*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #18*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v20.8h, v0.8h, v1.8h
   sub   v28.8h, v0.8h, v1.8h

   // 10
   ldr q4, [x1, #24*16]
   ldr q3, [x4, #24*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #24*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 11
   ldr q4, [x1, #66*16]
   ldr q3, [x4, #66*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #66*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v21.8h, v0.8h, v1.8h
   sub   v29.8h, v0.8h, v1.8h

   // 12
   ldr q4, [x1, #84*16]
   ldr q3, [x4, #84*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #84*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 13
   ldr q4, [x1, #6*16]
   ldr q3, [x4, #6*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #6*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v22.8h, v0.8h, v1.8h
   sub   v30.8h, v0.8h, v1.8h

   // 14
   ldr q4, [x1, #60*16]
   ldr q3, [x4, #60*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #60*16]
   MUL   v0.8h, v4.8h, v3.8h
   MLS   v0.8h, v2.8h, v9.8h
   // 15
   ldr q4, [x1, #30*16]
   ldr q3, [x4, #30*16+1536]
   SQRDMULH v2.8h, v4.8h, v3.8h
   ldr   q3, [x4, #30*16]
   MUL   v1.8h, v4.8h, v3.8h
   MLS   v1.8h, v2.8h, v9.8h
   add   v23.8h, v0.8h, v1.8h
   sub   v31.8h, v0.8h, v1.8h

   //v16-23 (x^8-1)
   // arguments
   mov      w7, #0x232f
   movk     w7, #0x7, lsl #16
   DUP      v8.4S,  w7

   //load twiddle
   ldr q2, [x2, #0*16]
   ldr q3, [x3, #0*16]

   // c[0] c[14] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v2.8h[0]
   SMULL2   v15.4S,  v16.8h,  v2.8h[0]
   SMULL    v11.4S,  v23.4h,  v2.4h[7]
   SMULL2   v12.4S,  v23.8h,  v2.8h[7]
   // c[6] c[8]
   SMLAL    v11.4S,  v16.4h,  v2.4h[6]
   SMLAL2   v12.4S,  v16.8h,  v2.8h[6]
   SMLAL    v14.4S,  v17.4h,  v2.4h[7]
   SMLAL2   v15.4S,  v17.8h,  v2.8h[7]
   SMLAL    v11.4S,  v17.4h,  v2.4h[5]
   SMLAL2   v12.4S,  v17.8h,  v2.8h[5]
   SMLAL    v14.4S,  v18.4h,  v2.4h[6]
   SMLAL2   v15.4S,  v18.8h,  v2.8h[6]
   SMLAL    v11.4S,  v18.4h,  v2.4h[4]
   SMLAL2   v12.4S,  v18.8h,  v2.8h[4]
   SMLAL    v14.4S,  v19.4h,  v2.4h[5]
   SMLAL2   v15.4S,  v19.8h,  v2.8h[5]
   SMLAL    v11.4S,  v19.4h,  v2.4h[3]
   SMLAL2   v12.4S,  v19.8h,  v2.8h[3]
   SMLAL    v14.4S,  v20.4h,  v2.4h[4]
   SMLAL2   v15.4S,  v20.8h,  v2.8h[4]
   SMLAL    v11.4S,  v20.4h,  v2.4h[2]
   SMLAL2   v12.4S,  v20.8h,  v2.8h[2]
   SMLAL    v14.4S,  v21.4h,  v2.4h[3]
   SMLAL2   v15.4S,  v21.8h,  v2.8h[3]
   SMLAL    v11.4S,  v21.4h,  v2.4h[1]
   SMLAL2   v12.4S,  v21.8h,  v2.8h[1]
   SMLAL    v14.4S,  v22.4h,  v2.4h[2]
   SMLAL2   v15.4S,  v22.8h,  v2.8h[2]
   SMLAL    v11.4S,  v22.4h,  v2.4h[0]
   SMLAL2   v12.4S,  v22.8h,  v2.8h[0]
   SMLAL    v14.4S,  v23.4h,  v2.4h[1]
   SMLAL2   v15.4S,  v23.8h,  v2.8h[1]

   // c[0] c[14] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v3.4h[0]
   SMULL2   v1.4S,  v24.8h,  v3.8h[0]
   SMULL    v6.4S,  v31.4h,  v3.4h[7]
   SMULL2   v7.4S,  v31.8h,  v3.8h[7]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   // c[6] c[8]
   SMLAL    v6.4S,  v24.4h,  v3.4h[6]
   SMLAL2   v7.4S,  v24.8h,  v3.8h[6]
   SMLSL    v0.4S,  v25.4h,  v3.4h[7]
   SMLSL2   v1.4S,  v25.8h,  v3.8h[7]
   SMLAL    v6.4S,  v25.4h,  v3.4h[5]
   SMLAL2   v7.4S,  v25.8h,  v3.8h[5]
   SMLSL    v0.4S,  v26.4h,  v3.4h[6]
   SMLSL2   v1.4S,  v26.8h,  v3.8h[6]
   SMLAL    v6.4S,  v26.4h,  v3.4h[4]
   SMLAL2   v7.4S,  v26.8h,  v3.8h[4]
   SMLSL    v0.4S,  v27.4h,  v3.4h[5]
   SMLSL2   v1.4S,  v27.8h,  v3.8h[5]
   SMLAL    v6.4S,  v27.4h,  v3.4h[3]
   SMLAL2   v7.4S,  v27.8h,  v3.8h[3]
   SMLSL    v0.4S,  v28.4h,  v3.4h[4]
   SMLSL2   v1.4S,  v28.8h,  v3.8h[4]
   SMLAL    v6.4S,  v28.4h,  v3.4h[2]
   SMLAL2   v7.4S,  v28.8h,  v3.8h[2]
   SMLSL    v0.4S,  v29.4h,  v3.4h[3]
   SMLSL2   v1.4S,  v29.8h,  v3.8h[3]
   SMLAL    v6.4S,  v29.4h,  v3.4h[1]
   SMLAL2   v7.4S,  v29.8h,  v3.8h[1]
   SMLSL    v0.4S,  v30.4h,  v3.4h[2]
   SMLSL2   v1.4S,  v30.8h,  v3.8h[2]
   SMLAL    v6.4S,  v30.4h,  v3.4h[0]
   SMLAL2   v7.4S,  v30.8h,  v3.8h[0]
   SMLSL    v0.4S,  v31.4h,  v3.4h[1]
   SMLSL2   v1.4S,  v31.8h,  v3.8h[1]

   // GS-butterfly
   //  5: p0 low   14+0
   // 14: n0 low   14-0
   //  0: p0 high  15+1
   // 15: n0 high  15-1 
   //  1: p6 low   11+6
   // 11: n6 low   11-6
   //  6: p6 high  12+7
   // 12: n6 high  12-7
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S
   
   // barrett [0][6]p low :05 16
   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   STR      q13,     [x0, #30*16]
   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   STR      q10,     [x0, #78*16]

   // barrett [0][6]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x0, #60*16]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x0, #12*16]


   //;c[1] c[13] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v2.4h[1]   
   SMULL2   v15.4S,  v16.8h,  v2.8h[1]   
   SMULL    v11.4S,  v22.4h,  v2.4h[7]
   SMULL2   v12.4S,  v22.8h,  v2.8h[7]
   SMLAL    v14.4S,  v17.4h,  v2.4h[0]
   SMLAL2   v15.4S,  v17.8h,  v2.8h[0]
   SMLAL    v11.4S,  v23.4h,  v2.4h[6]
   SMLAL2   v12.4S,  v23.8h,  v2.8h[6]
   //;c[5] c[9]
   SMLAL    v11.4S,  v16.4h,  v2.4h[5]
   SMLAL2   v12.4S,  v16.8h,  v2.8h[5]
   SMLAL    v14.4S,  v18.4h,  v2.4h[7]
   SMLAL2   v15.4S,  v18.8h,  v2.8h[7]
   SMLAL    v11.4S,  v17.4h,  v2.4h[4]
   SMLAL2   v12.4S,  v17.8h,  v2.8h[4]
   SMLAL    v14.4S,  v19.4h,  v2.4h[6]
   SMLAL2   v15.4S,  v19.8h,  v2.8h[6]
   SMLAL    v11.4S,  v18.4h,  v2.4h[3]
   SMLAL2   v12.4S,  v18.8h,  v2.8h[3]
   SMLAL    v14.4S,  v20.4h,  v2.4h[5]
   SMLAL2   v15.4S,  v20.8h,  v2.8h[5]
   SMLAL    v11.4S,  v19.4h,  v2.4h[2]
   SMLAL2   v12.4S,  v19.8h,  v2.8h[2]
   SMLAL    v14.4S,  v21.4h,  v2.4h[4]
   SMLAL2   v15.4S,  v21.8h,  v2.8h[4]
   SMLAL    v11.4S,  v20.4h,  v2.4h[1]
   SMLAL2   v12.4S,  v20.8h,  v2.8h[1]
   SMLAL    v14.4S,  v22.4h,  v2.4h[3]
   SMLAL2   v15.4S,  v22.8h,  v2.8h[3]
   SMLAL    v11.4S,  v21.4h,  v2.4h[0]
   SMLAL2   v12.4S,  v21.8h,  v2.8h[0]
   SMLAL    v14.4S,  v23.4h,  v2.4h[2]
   SMLAL2   v15.4S,  v23.8h,  v2.8h[2]

   //;c[1] c[13] for (x^8+1) 
   SMULL    v0.4S,  v24.4h,  v3.4h[1]   
   SMULL2   v1.4S,  v24.8h,  v3.8h[1]   
   SMULL    v6.4S,  v30.4h,  v3.4h[7]
   SMULL2   v7.4S,  v30.8h,  v3.8h[7]
   SMLAL    v0.4S,  v25.4h,  v3.4h[0]
   SMLAL2   v1.4S,  v25.8h,  v3.8h[0]
   SMLAL    v6.4S,  v31.4h,  v3.4h[6]
   SMLAL2   v7.4S,  v31.8h,  v3.8h[6]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   //;c[5] c[9]
   SMLAL    v6.4S,  v24.4h,  v3.4h[5]
   SMLAL2   v7.4S,  v24.8h,  v3.8h[5]
   SMLSL    v0.4S,  v26.4h,  v3.4h[7]
   SMLSL2   v1.4S,  v26.8h,  v3.8h[7]
   SMLAL    v6.4S,  v25.4h,  v3.4h[4]
   SMLAL2   v7.4S,  v25.8h,  v3.8h[4]
   SMLSL    v0.4S,  v27.4h,  v3.4h[6]
   SMLSL2   v1.4S,  v27.8h,  v3.8h[6]
   SMLAL    v6.4S,  v26.4h,  v3.4h[3]
   SMLAL2   v7.4S,  v26.8h,  v3.8h[3]
   SMLSL    v0.4S,  v28.4h,  v3.4h[5]
   SMLSL2   v1.4S,  v28.8h,  v3.8h[5]
   SMLAL    v6.4S,  v27.4h,  v3.4h[2]
   SMLAL2   v7.4S,  v27.8h,  v3.8h[2]
   SMLSL    v0.4S,  v29.4h,  v3.4h[4]
   SMLSL2   v1.4S,  v29.8h,  v3.8h[4]
   SMLAL    v6.4S,  v28.4h,  v3.4h[1]
   SMLAL2   v7.4S,  v28.8h,  v3.8h[1]
   SMLSL    v0.4S,  v30.4h,  v3.4h[3]
   SMLSL2   v1.4S,  v30.8h,  v3.8h[3]
   SMLAL    v6.4S,  v29.4h,  v3.4h[0]
   SMLAL2   v7.4S,  v29.8h,  v3.8h[0]
   SMLSL    v0.4S,  v31.4h,  v3.4h[2]
   SMLSL2   v1.4S,  v31.8h,  v3.8h[2]

   //;barrett [1][5]p
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   STR      q13,     [x0, #6*16]
   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   STR      q10,     [x0, #42*16]

   // barrett [1][5]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x0, #84*16]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x0, #48*16]


   //;c[2] c[12] for (x^8-1)
   SMULL    v14.4S,  v16.4h,  v2.h[2]
   SMULL2   v15.4S,  v16.8h,  v2.8h[2]
   SMULL    v11.4S,  v21.4h,  v2.4h[7]
   SMULL2   v12.4S,  v21.8h,  v2.8h[7]
   SMLAL    v14.4S,  v17.4h,  v2.4h[1]
   SMLAL2   v15.4S,  v17.8h,  v2.8h[1]
   SMLAL    v11.4S,  v22.4h,  v2.4h[6]
   SMLAL2   v12.4S,  v22.8h,  v2.8h[6]
   SMLAL    v14.4S,  v18.4h,  v2.4h[0]
   SMLAL2   v15.4S,  v18.8h,  v2.8h[0]
   SMLAL    v11.4S,  v23.4h,  v2.4h[5]
   SMLAL2   v12.4S,  v23.8h,  v2.8h[5]
   //;c[4] c[10]
   SMLAL    v11.4S,  v16.4h,  v2.4h[4]
   SMLAL2   v12.4S,  v16.8h,  v2.8h[4]
   SMLAL    v14.4S,  v19.4h,  v2.4h[7]
   SMLAL2   v15.4S,  v19.8h,  v2.8h[7]
   SMLAL    v11.4S,  v17.4h,  v2.4h[3]
   SMLAL2   v12.4S,  v17.8h,  v2.8h[3]
   SMLAL    v14.4S,  v20.4h,  v2.4h[6]
   SMLAL2   v15.4S,  v20.8h,  v2.8h[6]
   SMLAL    v11.4S,  v18.4h,  v2.4h[2]
   SMLAL2   v12.4S,  v18.8h,  v2.8h[2]
   SMLAL    v14.4S,  v21.4h,  v2.4h[5]
   SMLAL2   v15.4S,  v21.8h,  v2.8h[5]
   SMLAL    v11.4S,  v19.4h,  v2.4h[1]
   SMLAL2   v12.4S,  v19.8h,  v2.8h[1]
   SMLAL    v14.4S,  v22.4h,  v2.4h[4]
   SMLAL2   v15.4S,  v22.8h,  v2.8h[4]
   SMLAL    v11.4S,  v20.4h,  v2.4h[0]
   SMLAL2   v12.4S,  v20.8h,  v2.8h[0]
   SMLAL    v14.4S,  v23.4h,  v2.4h[3]
   SMLAL2   v15.4S,  v23.8h,  v2.8h[3]

   //;c[2] c[12] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v3.4h[2]
   SMULL2   v1.4S,  v24.8h,  v3.8h[2]
   SMULL    v6.4S,  v29.4h,  v3.4h[7]
   SMULL2   v7.4S,  v29.8h,  v3.8h[7]
   SMLAL    v0.4S,  v25.4h,  v3.4h[1]
   SMLAL2   v1.4S,  v25.8h,  v3.8h[1]
   SMLAL    v6.4S,  v30.4h,  v3.4h[6]
   SMLAL2   v7.4S,  v30.8h,  v3.8h[6]
   SMLAL    v0.4S,  v26.4h,  v3.4h[0]
   SMLAL2   v1.4S,  v26.8h,  v3.8h[0]
   SMLAL    v6.4S,  v31.4h,  v3.4h[5]
   SMLAL2   v7.4S,  v31.8h,  v3.8h[5]
   NEG     v6.4S,   v6.4S
   NEG     v7.4S,   v7.4S
   //;c[4] c[10]
   SMLAL    v6.4S,  v24.4h,  v3.4h[4]
   SMLAL2   v7.4S,  v24.8h,  v3.8h[4]
   SMLSL    v0.4S,  v27.4h,  v3.4h[7]
   SMLSL2   v1.4S,  v27.8h,  v3.8h[7]
   SMLAL    v6.4S,  v25.4h,  v3.4h[3]
   SMLAL2   v7.4S,  v25.8h,  v3.8h[3]
   SMLSL    v0.4S,  v28.4h,  v3.4h[6]
   SMLSL2   v1.4S,  v28.8h,  v3.8h[6]
   SMLAL    v6.4S,  v26.4h,  v3.4h[2]
   SMLAL2   v7.4S,  v26.8h,  v3.8h[2]
   SMLSL    v0.4S,  v29.4h,  v3.4h[5]
   SMLSL2   v1.4S,  v29.8h,  v3.8h[5]
   SMLAL    v6.4S,  v27.4h,  v3.4h[1]
   SMLAL2   v7.4S,  v27.8h,  v3.8h[1]
   SMLSL    v0.4S,  v30.4h,  v3.4h[4]
   SMLSL2   v1.4S,  v30.8h,  v3.8h[4]
   SMLAL    v6.4S,  v28.4h,  v3.4h[0]
   SMLAL2   v7.4S,  v28.8h,  v3.8h[0]
   SMLSL    v0.4S,  v31.4h,  v3.4h[3]
   SMLSL2   v1.4S,  v31.8h,  v3.8h[3]

   //;barrett [2][4]p
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   STR      q13,     [x0, #66*16]
   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   STR      q10,     [x0, #36*16]

   // barrett [2][4]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x0, #24*16]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x0, #54*16]


   //;c[3] c[11]
   SMULL    v14.4S,  v16.4h,  v2.4h[3]
   SMULL2   v15.4S,  v16.8h,  v2.8h[3]
   SMLAL    v14.4S,  v20.4h,  v2.4h[7]
   SMLAL2   v15.4S,  v20.8h,  v2.8h[7]
   SMLAL    v14.4S,  v17.4h,  v2.4h[2]
   SMLAL2   v15.4S,  v17.8h,  v2.8h[2]
   SMLAL    v14.4S,  v21.4h,  v2.4h[6]
   SMLAL2   v15.4S,  v21.8h,  v2.8h[6]
   SMLAL    v14.4S,  v18.4h,  v2.4h[1]
   SMLAL2   v15.4S,  v18.8h,  v2.8h[1]
   SMLAL    v14.4S,  v22.4h,  v2.4h[5]
   SMLAL2   v15.4S,  v22.8h,  v2.8h[5]
   SMLAL    v14.4S,  v19.4h,  v2.4h[0]
   SMLAL2   v15.4S,  v19.8h,  v2.8h[0]
   SMLAL    v14.4S,  v23.4h,  v2.4h[4]
   SMLAL2   v15.4S,  v23.8h,  v2.8h[4]
   //;c[7]
   SMULL    v11.4S,  v16.4h,  v2.4h[7]
   SMULL2   v12.4S,  v16.8h,  v2.8h[7]
   SMLAL    v11.4S,  v17.4h,  v2.4h[6]
   SMLAL2   v12.4S,  v17.8h,  v2.8h[6]
   SMLAL    v11.4S,  v18.4h,  v2.4h[5]
   SMLAL2   v12.4S,  v18.8h,  v2.8h[5]
   SMLAL    v11.4S,  v19.4h,  v2.4h[4]
   SMLAL2   v12.4S,  v19.8h,  v2.8h[4]
   SMLAL    v11.4S,  v20.4h,  v2.4h[3]
   SMLAL2   v12.4S,  v20.8h,  v2.8h[3]
   SMLAL    v11.4S,  v21.4h,  v2.4h[2]
   SMLAL2   v12.4S,  v21.8h,  v2.8h[2]
   SMLAL    v11.4S,  v22.4h,  v2.4h[1]
   SMLAL2   v12.4S,  v22.8h,  v2.8h[1]
   SMLAL    v11.4S,  v23.4h,  v2.4h[0]
   SMLAL2   v12.4S,  v23.8h,  v2.8h[0]

   //;c[3] c[11] for (x^8+1)
   SMULL    v0.4S,  v24.4h,  v3.4h[3]
   SMULL2   v1.4S,  v24.8h,  v3.8h[3]
   SMLSL    v0.4S,  v28.4h,  v3.4h[7]
   SMLSL2   v1.4S,  v28.8h,  v3.8h[7]
   SMLAL    v0.4S,  v25.4h,  v3.4h[2]
   SMLAL2   v1.4S,  v25.8h,  v3.8h[2]
   SMLSL    v0.4S,  v29.4h,  v3.4h[6]
   SMLSL2   v1.4S,  v29.8h,  v3.8h[6]
   SMLAL    v0.4S,  v26.4h,  v3.4h[1]
   SMLAL2   v1.4S,  v26.8h,  v3.8h[1]
   SMLSL    v0.4S,  v30.4h,  v3.4h[5]
   SMLSL2   v1.4S,  v30.8h,  v3.8h[5]
   SMLAL    v0.4S,  v27.4h,  v3.4h[0]
   SMLAL2   v1.4S,  v27.8h,  v3.8h[0]
   SMLSL    v0.4S,  v31.4h,  v3.4h[4]
   SMLSL2   v1.4S,  v31.8h,  v3.8h[4]
   //;c[7]
   SMULL    v6.4S,  v24.4h,  v3.4h[7]
   SMULL2   v7.4S,  v24.8h,  v3.8h[7]
   SMLAL    v6.4S,  v25.4h,  v3.4h[6]
   SMLAL2   v7.4S,  v25.8h,  v3.8h[6]
   SMLAL    v6.4S,  v26.4h,  v3.4h[5]
   SMLAL2   v7.4S,  v26.8h,  v3.8h[5]
   SMLAL    v6.4S,  v27.4h,  v3.4h[4]
   SMLAL2   v7.4S,  v27.8h,  v3.8h[4]
   SMLAL    v6.4S,  v28.4h,  v3.4h[3]
   SMLAL2   v7.4S,  v28.8h,  v3.8h[3]
   SMLAL    v6.4S,  v29.4h,  v3.4h[2]
   SMLAL2   v7.4S,  v29.8h,  v3.8h[2]
   SMLAL    v6.4S,  v30.4h,  v3.4h[1]
   SMLAL2   v7.4S,  v30.8h,  v3.8h[1]
   SMLAL    v6.4S,  v31.4h,  v3.4h[0]
   SMLAL2   v7.4S,  v31.8h,  v3.8h[0]

   //  5: p3 low
   // 14: n3 low 
   //  0: p3 high
   // 15: n3 high
   //  1: p7 low
   // 11: n7 low
   //  6: p7 high
   // 12: n7 high 
   ADD      v5.4S, v14.4S, v0.4S
   SUB      v14.4S, v14.4S, v0.4S
   ADD      v0.4S, v15.4S, v1.4S
   SUB      v15.4S, v15.4S, v1.4S
   ADD      v1.4S, v11.4S, v6.4S
   SUB      v11.4S, v11.4S, v6.4S
   ADD      v6.4S, v12.4S, v7.4S
   SUB      v12.4S, v12.4S, v7.4S

   //;barrett[3][7]p
   UZP1     v13.8h,  v5.8h,  v0.8h
   SQRDMULH v5.4S,  v5.4S,  v8.4S
   UZP1     v10.8h,  v1.8h,  v6.8h
   SQRDMULH v0.4S,  v0.4S,  v8.4S
   UZP1     v5.8h,  v5.8h,  v0.8h
   SQRDMULH v1.4S,  v1.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v5.8h
   SQRDMULH v6.4S,  v6.4S,  v8.4S
   STR      q13,     [x0, #18*16]

   UZP1     v1.8h,  v1.8h,  v6.8h
   MLS      v10.8h,  v9.8h,   v1.8h
   STR      q10,     [x0, #90*16]

   // barrett [3][7]n
   UZP1     v13.8h,  v14.8h,  v15.8h
   SQRDMULH v14.4S,  v14.4S,  v8.4S
   UZP1     v10.8h,  v11.8h,  v12.8h
   SQRDMULH v15.4S,  v15.4S,  v8.4S
   UZP1     v14.8h,  v14.8h,  v15.8h
   SQRDMULH v11.4S,  v11.4S,  v8.4S
   MLS      v13.8h,  v9.8h,   v14.8h
   SQRDMULH v12.4S,  v12.4S,  v8.4S
   STR      q13,     [x0, #72*16]
   UZP1     v11.8h,  v11.8h,  v12.8h
   MLS      v10.8h,  v9.8h,   v11.8h
   STR      q10,     [x0, #0*16]

   ret
