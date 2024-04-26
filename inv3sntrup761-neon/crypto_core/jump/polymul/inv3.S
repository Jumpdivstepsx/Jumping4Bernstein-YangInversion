.align 6
.global transposeCompress
.global _transposeCompress
.global transposeCompress_2
.global _transposeCompress_2
.global itransposeCompress
.global _itransposeCompress
.global itransposeCompress_2
.global _itransposeCompress_2
.global poly64x64
.global _poly64x64

transposeCompress:
_transposeCompress:

    ldr q8, [x1, #0*16]
    ldr q9, [x1, #1*16]
    ldr q10, [x1, #2*16]
    ldr q11, [x1, #3*16]
    ldr q12, [x1, #4*16]
    ldr q13, [x1, #5*16]
    ldr q14, [x1, #6*16]
    ldr q15, [x1, #7*16]

    trn1 v24.2d, v8.2d, v12.2d
    trn1 v26.2d, v9.2d, v13.2d
    trn1 v28.2d, v10.2d, v14.2d    
    trn1 v30.2d, v11.2d, v15.2d
    trn2 v25.2d, v8.2d, v12.2d
    trn2 v27.2d, v9.2d, v13.2d
    trn2 v29.2d, v10.2d, v14.2d    
    trn2 v31.2d, v11.2d, v15.2d

    trn1 v8.4s, v24.4s, v28.4s
    trn1 v9.4s, v25.4s, v29.4s
    trn1 v10.4s, v26.4s, v30.4s
    trn1 v11.4s, v27.4s, v31.4s
    trn2 v12.4s, v24.4s, v28.4s
    trn2 v13.4s, v25.4s, v29.4s
    trn2 v14.4s, v26.4s, v30.4s
    trn2 v15.4s, v27.4s, v31.4s

    trn1 v24.8h, v8.8h, v10.8h
    trn1 v25.8h, v9.8h, v11.8h
    trn1 v28.8h, v12.8h, v14.8h
    trn1 v29.8h, v13.8h, v15.8h
    trn2 v26.8h, v8.8h, v10.8h
    trn2 v27.8h, v9.8h, v11.8h
    trn2 v30.8h, v12.8h, v14.8h
    trn2 v31.8h, v13.8h, v15.8h

    trn1 v8.16b, v24.16b, v25.16b
    trn1 v10.16b, v26.16b, v27.16b
    trn1 v12.16b, v28.16b, v29.16b
    trn1 v14.16b, v30.16b, v31.16b
    trn2 v9.16b, v24.16b, v25.16b
    trn2 v11.16b, v26.16b, v27.16b
    trn2 v13.16b, v28.16b, v29.16b
    trn2 v15.16b, v30.16b, v31.16b
    

    str q8, [x0, #0*16]
    str q9, [x0, #1*16]
    str q10, [x0, #2*16]
    str q11, [x0, #3*16]
    str q12, [x0, #4*16]
    str q13, [x0, #5*16]
    str q14, [x0, #6*16]
    str q15, [x0, #7*16]

    ret

transposeCompress_2:
_transposeCompress_2:

    ldr q8, [x2, #0*16]
    ldr q9, [x2, #1*16]
    ldr q10, [x2, #2*16]
    ldr q11, [x2, #3*16]
    ldr q12, [x2, #4*16]
    ldr q13, [x2, #5*16]
    ldr q14, [x2, #6*16]
    ldr q15, [x2, #7*16]

    trn1 v24.2d, v8.2d, v12.2d
    trn1 v26.2d, v9.2d, v13.2d
    trn1 v28.2d, v10.2d, v14.2d    
    trn1 v30.2d, v11.2d, v15.2d
    trn2 v25.2d, v8.2d, v12.2d
    trn2 v27.2d, v9.2d, v13.2d
    trn2 v29.2d, v10.2d, v14.2d    
    trn2 v31.2d, v11.2d, v15.2d

    trn1 v8.4s, v24.4s, v28.4s
    trn1 v9.4s, v25.4s, v29.4s
    trn1 v10.4s, v26.4s, v30.4s
    trn1 v11.4s, v27.4s, v31.4s
    trn2 v12.4s, v24.4s, v28.4s
    trn2 v13.4s, v25.4s, v29.4s
    trn2 v14.4s, v26.4s, v30.4s
    trn2 v15.4s, v27.4s, v31.4s

    trn1 v24.8h, v8.8h, v10.8h
    trn1 v25.8h, v9.8h, v11.8h
    trn1 v28.8h, v12.8h, v14.8h
    trn1 v29.8h, v13.8h, v15.8h
    trn2 v26.8h, v8.8h, v10.8h
    trn2 v27.8h, v9.8h, v11.8h
    trn2 v30.8h, v12.8h, v14.8h
    trn2 v31.8h, v13.8h, v15.8h

    trn1 v8.16b, v24.16b, v25.16b
    trn1 v10.16b, v26.16b, v27.16b
    trn1 v12.16b, v28.16b, v29.16b
    trn1 v14.16b, v30.16b, v31.16b
    trn2 v9.16b, v24.16b, v25.16b
    trn2 v11.16b, v26.16b, v27.16b
    trn2 v13.16b, v28.16b, v29.16b
    trn2 v15.16b, v30.16b, v31.16b
    
    ldr q16, [x0, #0*16]
    ldr q17, [x1, #0*16]
    ldr q18, [x3, #0*16]
    ldr q19, [x4, #0*16]

    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v15.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v15.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v14.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v14.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v13.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v13.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v12.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v12.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v11.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v11.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v10.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v10.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v9.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v9.16b
    add v17.16b, v17.16b, v20.16b
    shl v16.16b, v16.16b, #1
    tbl v20.16b, {v18.16b}, v8.16b
    add v16.16b, v16.16b, v20.16b
    shl v17.16b, v17.16b, #1
    tbl v20.16b, {v19.16b}, v8.16b
    add v17.16b, v17.16b, v20.16b

    str q16, [x0, #0*16]
    str q17, [x1, #0*16]
    ret

itransposeCompress:
_itransposeCompress:

    ldr q24, [x1, #0*16]
    ldr q25, [x1, #1*16]
    ldr q26, [x1, #2*16]
    ldr q27, [x1, #3*16]
    ldr q28, [x1, #4*16]
    ldr q29, [x1, #5*16]
    ldr q30, [x1, #6*16]
    ldr q31, [x1, #7*16]

    trn1 v8.4s, v24.4s, v28.4s
    trn1 v9.4s, v25.4s, v29.4s
    trn1 v10.4s, v26.4s, v30.4s
    trn1 v11.4s, v27.4s, v31.4s
    trn2 v12.4s, v24.4s, v28.4s
    trn2 v13.4s, v25.4s, v29.4s
    trn2 v14.4s, v26.4s, v30.4s
    trn2 v15.4s, v27.4s, v31.4s

    trn1 v24.8h, v8.8h, v10.8h
    trn1 v25.8h, v9.8h, v11.8h
    trn1 v28.8h, v12.8h, v14.8h
    trn1 v29.8h, v13.8h, v15.8h
    trn2 v26.8h, v8.8h, v10.8h
    trn2 v27.8h, v9.8h, v11.8h
    trn2 v30.8h, v12.8h, v14.8h
    trn2 v31.8h, v13.8h, v15.8h

    trn1 v8.16b, v24.16b, v25.16b
    trn1 v10.16b, v26.16b, v27.16b
    trn1 v12.16b, v28.16b, v29.16b
    trn1 v14.16b, v30.16b, v31.16b
    trn2 v9.16b, v24.16b, v25.16b
    trn2 v11.16b, v26.16b, v27.16b
    trn2 v13.16b, v28.16b, v29.16b
    trn2 v15.16b, v30.16b, v31.16b
    
    trn1 v24.2d, v8.2d, v9.2d
    trn1 v25.2d, v10.2d, v11.2d
    trn1 v26.2d, v12.2d, v13.2d    
    trn1 v27.2d, v14.2d, v15.2d
    trn2 v28.2d, v8.2d, v9.2d
    trn2 v29.2d, v10.2d, v11.2d
    trn2 v30.2d, v12.2d, v13.2d    
    trn2 v31.2d, v14.2d, v15.2d
    

    str q24, [x0, #0*16]
    str q25, [x0, #1*16]
    str q26, [x0, #2*16]
    str q27, [x0, #3*16]
    str q28, [x0, #4*16]
    str q29, [x0, #5*16]
    str q30, [x0, #6*16]
    str q31, [x0, #7*16]

    ret

itransposeCompress_2:
_itransposeCompress_2:

    ldr q8, [x1, #0]
    ldr q9, [x2, #0]
    mov w5, #1
    dup v10.16b, w5

    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v24.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v25.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v26.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v27.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v28.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v29.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v30.16b, v11.16b, v12.16b
    ushr v8.16b, v8.16b, #1
    ushr v9.16b, v9.16b, #1
    and v11.16b, v8.16b, v10.16b
    and v12.16b, v9.16b, v10.16b
    add v31.16b, v11.16b, v12.16b

    trn1 v8.4s, v24.4s, v28.4s
    trn1 v9.4s, v25.4s, v29.4s
    trn1 v10.4s, v26.4s, v30.4s
    trn1 v11.4s, v27.4s, v31.4s
    trn2 v12.4s, v24.4s, v28.4s
    trn2 v13.4s, v25.4s, v29.4s
    trn2 v14.4s, v26.4s, v30.4s
    trn2 v15.4s, v27.4s, v31.4s

    trn1 v24.8h, v8.8h, v10.8h
    trn1 v25.8h, v9.8h, v11.8h
    trn1 v28.8h, v12.8h, v14.8h
    trn1 v29.8h, v13.8h, v15.8h
    trn2 v26.8h, v8.8h, v10.8h
    trn2 v27.8h, v9.8h, v11.8h
    trn2 v30.8h, v12.8h, v14.8h
    trn2 v31.8h, v13.8h, v15.8h

    trn1 v8.16b, v24.16b, v25.16b
    trn1 v10.16b, v26.16b, v27.16b
    trn1 v12.16b, v28.16b, v29.16b
    trn1 v14.16b, v30.16b, v31.16b
    trn2 v9.16b, v24.16b, v25.16b
    trn2 v11.16b, v26.16b, v27.16b
    trn2 v13.16b, v28.16b, v29.16b
    trn2 v15.16b, v30.16b, v31.16b
    
    trn1 v24.2d, v8.2d, v9.2d
    trn1 v25.2d, v10.2d, v11.2d
    trn1 v26.2d, v12.2d, v13.2d    
    trn1 v27.2d, v14.2d, v15.2d
    trn2 v28.2d, v8.2d, v9.2d
    trn2 v29.2d, v10.2d, v11.2d
    trn2 v30.2d, v12.2d, v13.2d    
    trn2 v31.2d, v14.2d, v15.2d
    
    str q24, [x0, #0*16]
    str q25, [x0, #1*16]
    str q26, [x0, #2*16]
    str q27, [x0, #3*16]
    str q28, [x0, #4*16]
    str q29, [x0, #5*16]
    str q30, [x0, #6*16]
    str q31, [x0, #7*16]

    ret


poly64x64:
_poly64x64:
    //butterfly x1=a; x2=b
    ldp q0, q1,   [x1]
    ldp q2, q3,   [x1, #2*16]
    // trsnspose a
    zip1 v11.2d, v0.2d, v1.2d 
    zip2 v12.2d, v0.2d, v1.2d
    zip1 v0.4s, v11.4s, v12.4s
    zip2 v1.4s, v11.4s, v12.4s
    zip1 v11.2d, v2.2d, v3.2d 
    zip2 v12.2d, v2.2d, v3.2d
    zip1 v2.4s, v11.4s, v12.4s
    zip2 v3.4s, v11.4s, v12.4s
    ldp q9, q10, [x2]
    ldp q11, q12, [x2, #2*16]
    ldr q27, [x3]

    add v4.16B, v0.16b, v1.16b
    add v5.16B, v2.16b, v3.16b
    add v6.16B, v0.16b, v2.16b
    add v7.16B, v1.16b, v3.16b
    add v8.16B, v4.16b, v5.16b
    add v13.16B, v9.16b, v10.16b
    add v14.16B, v11.16b, v12.16b
    add v15.16B, v9.16b, v11.16b
    add v16.16B, v10.16b, v12.16b
    add v17.16B, v13.16b, v14.16b

    TBL v6.16b, {v27.16b}, v6.16b
    TBL v7.16b, {v27.16b}, v7.16b
    TBL v8.16b, {v27.16b}, v8.16b
    TBL v13.16b, {v27.16b}, v13.16b
    TBL v14.16b, {v27.16b}, v14.16b
    TBL v15.16b, {v27.16b}, v15.16b
    TBL v16.16b, {v27.16b}, v16.16b
    TBL v17.16b, {v27.16b}, v17.16b
    
    MOVI v30.16b, #0x0
    MOVI v31.16b, #0xf

    // c0
    umull2 v26.2d, v0.4s, v9.s[0]
    umull2 v28.2d, v0.4s, v9.s[1]
    umull2 v29.2d, v0.4s, v9.s[2]
    umlal  v26.2d, v0.2s,  v9.s[1]
    umlal  v28.2d, v0.2s,  v9.s[2]
    umlal  v29.2d, v0.2s,  v9.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v0.4s, v9.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v0.2s, v9.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v1.4s, v10.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v0.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v0.16b, {v27.16b}, v0.16b
    usra   v0.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v1.4s, v10.s[1]
    tbl	   v0.16b, {v27.16b}, v0.16b
    tbl	   v9.16b, {v27.16b}, v21.16b

    // c1
    umull2 v29.2d, v1.4s, v10.s[2]
    umlal  v26.2d, v1.2s,  v10.s[1]
    umlal  v28.2d, v1.2s,  v10.s[2]
    umlal  v29.2d, v1.2s,  v10.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v1.4s, v10.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v1.2s, v10.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v2.4s, v11.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v1.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v1.16b, {v27.16b}, v1.16b
    usra   v1.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v2.4s, v11.s[1]
    tbl	   v1.16b, {v27.16b}, v1.16b
    umull2 v29.2d, v2.4s, v11.s[2]
    tbl	   v10.16b, {v27.16b}, v21.16b

    // c2
    umlal  v26.2d, v2.2s,  v11.s[1]
    umlal  v28.2d, v2.2s,  v11.s[2]
    umlal  v29.2d, v2.2s,  v11.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v2.4s, v11.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v2.2s, v11.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v3.4s, v12.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v2.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v2.16b, {v27.16b}, v2.16b
    usra   v2.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v3.4s, v12.s[1]
    tbl	   v2.16b, {v27.16b}, v2.16b
    umull2 v29.2d, v3.4s, v12.s[2]
    tbl	   v11.16b, {v27.16b}, v21.16b

    // c3
    umlal  v26.2d, v3.2s,  v12.s[1]
    umlal  v28.2d, v3.2s,  v12.s[2]
    umlal  v29.2d, v3.2s,  v12.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v3.4s, v12.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v3.2s, v12.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v4.4s, v13.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v3.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v3.16b, {v27.16b}, v3.16b
    usra   v3.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v4.4s, v13.s[1]
    tbl	   v3.16b, {v27.16b}, v3.16b
    umull2 v29.2d, v4.4s, v13.s[2]
    tbl	   v12.16b, {v27.16b}, v21.16b

    // c4
    umlal  v26.2d, v4.2s,  v13.s[1]
    umlal  v28.2d, v4.2s,  v13.s[2]
    umlal  v29.2d, v4.2s,  v13.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v4.4s, v13.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v4.2s, v13.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v5.4s, v14.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v4.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v4.16b, {v27.16b}, v4.16b
    usra   v4.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v5.4s, v14.s[1]
    tbl	   v4.16b, {v27.16b}, v4.16b
    umull2 v29.2d, v5.4s, v14.s[2]
    tbl	   v13.16b, {v27.16b}, v21.16b
    
    // c5
    umlal  v26.2d, v5.2s,  v14.s[1]
    umlal  v28.2d, v5.2s,  v14.s[2]
    umlal  v29.2d, v5.2s,  v14.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v5.4s, v14.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v5.2s, v14.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v6.4s, v15.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v5.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v5.16b, {v27.16b}, v5.16b
    usra   v5.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v6.4s, v15.s[1]
    tbl	   v5.16b, {v27.16b}, v5.16b
    umull2 v29.2d, v6.4s, v15.s[2]
    tbl	   v14.16b, {v27.16b}, v21.16b

    // c6
    umlal  v26.2d, v6.2s,  v15.s[1]
    umlal  v28.2d, v6.2s,  v15.s[2]
    umlal  v29.2d, v6.2s,  v15.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v6.4s, v15.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v6.2s, v15.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v7.4s, v16.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v6.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v6.16b, {v27.16b}, v6.16b
    usra   v6.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v7.4s, v16.s[1]
    tbl	   v6.16b, {v27.16b}, v6.16b
    umull2 v29.2d, v7.4s, v16.s[2]
    tbl	   v15.16b, {v27.16b}, v21.16b

    // c7    
    umlal  v26.2d, v7.2s,  v16.s[1]
    umlal  v28.2d, v7.2s,  v16.s[2]
    umlal  v29.2d, v7.2s,  v16.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v7.4s, v16.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v7.2s, v16.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    umull2 v26.2d, v8.4s, v17.s[0]
    and	   v21.16b, v28.16b, v31.16b
    and	   v7.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v7.16b, {v27.16b}, v7.16b
    usra   v7.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    umull2 v28.2d, v8.4s, v17.s[1]
    tbl	   v7.16b, {v27.16b}, v7.16b
    tbl	   v16.16b, {v27.16b}, v21.16b
    
    // c8
    umull2 v29.2d, v8.4s, v17.s[2]
    umlal  v26.2d, v8.2s,  v17.s[1]
    umlal  v28.2d, v8.2s,  v17.s[2]
    umlal  v29.2d, v8.2s,  v17.s[3]
    ext    v21.16b,  v30.16b,  v26.16b, #12
    ext    v26.16b, v26.16b, v30.16b,  #12
    ext    v22.16b,  v30.16b,  v28.16b, #8
    ext    v23.16b,  v30.16b,  v29.16b, #4
    ext    v28.16b, v28.16b, v30.16b,  #8
    ext    v29.16b, v29.16b, v30.16b,  #4
    umlal2 v26.2d, v8.4s, v17.s[3]
    add	   v28.16b, v29.16b, v28.16b
    umlal  v21.2d, v8.2s, v17.s[0]
    add	   v23.16b, v22.16b, v23.16b
    add	   v28.16b, v28.16b, v26.16b
    add	   v23.16b, v23.16b, v21.16b
    and	   v21.16b, v28.16b, v31.16b
    and	   v8.16b, v23.16b, v31.16b
    tbl	   v21.16b, {v27.16b}, v21.16b
    tbl	   v8.16b, {v27.16b}, v8.16b
    usra   v8.16b, v23.16b, #4
    usra   v21.16b, v28.16b, #4
    tbl	   v8.16b, {v27.16b}, v8.16b
    tbl	   v17.16b, {v27.16b}, v21.16b

    //ibutterfly
    movi v29.16b, #9
    //arg0 = c18 + c20 [0~4]
    add v19.16b, v10.16b, v2.16b
    //arg1 = c10 - c08 [-2~2]
    sub v20.16b, v1.16b, v9.16b
    //arg3 = c28 - c30 [-2~2]
    sub v22.16b, v11.16b, v3.16b
    //arg2 = arg1 + c48 - arg0 [-4~4] ->[0,2]
    //arg4 = arg3 + c50 - arg0 [-6~4]->[0~2]
    add v21.16b, v20.16b, v13.16B
    add v23.16b, v22.16b, v5.16b
    sub v21.16b, v21.16b, v19.16b
    sub v23.16b, v23.16b, v19.16b
    add v21.16b, v21.16b, v29.16b
    add v23.16b, v23.16b, v29.16b
    TBL     v21.16b, {v27.16b}, v21.16b
    TBL     v23.16b, {v27.16b}, v23.16b 
    //arg5 = c68 - c70 [-2~2]
    sub v24.16b, v15.16b, v7.16b

    //out00 = c00 = v0 [0-2]
    //out08 = barrett_fake(c40 - (c00 + arg1)); [-2, 4] = [0,2]
    //out10 = barrett_fake(arg2 - c00 + c60); [-6~6] [-2,4]
    sub v1.16b, v4.16b, v0.16b
    sub v9.16b, v21.16b, v0.16b
    sub v1.16b, v1.16b, v20.16b
    add v9.16b, v9.16b, v6.16b
    add v1.16b, v1.16b, v29.16b
    add v9.16b, v9.16b, v29.16b
    TBL     v1.16b, {v27.16b}, v1.16b
    TBL     v9.16b, {v27.16b}, v9.16b

    //out18 = barrett_fake(arg5 + c80 - (arg4 + c60 + out08));    [-2,4] - [0,6] = [-8,4]
    //out30 = barrett_fake(c58 - (c38 + arg3)); [-4~4]
    add v10.16b, v24.16b, v8.16b
    add v6.16b, v6.16b, v23.16b
    sub v11.16b, v14.16b, v12.16b
    add v6.16b, v6.16b, v1.16b
    sub v11.16b, v11.16b, v22.16b
    sub v10.16b, v10.16b, v6.16b
    add v11.16b, v11.16b, v29.16b
    add v10.16b, v10.16b, v29.16b
    TBL v11.16b, {v27.16b}, v11.16b 
    TBL v10.16b, {v27.16b}, v10.16b
    
    //out28 = barrett_fake(arg4 - c38 + c78); [-2-4]
    //out20 = barrett_fake(c88 - (arg2 + arg5 + c78 + out30)); //[-8,4]
    add v21.16b, v21.16b, v24.16b
    sub v3.16b, v23.16b, v12.16b
    add v21.16b, v21.16b, v16.16b
    add v3.16b, v3.16b, v16.16b
    add v21.16b, v21.16b, v11.16b
    sub v2.16b, v17.16b, v21.16b
    add v3.16b, v3.16b, v29.16b
    add v2.16b, v2.16b, v29.16b
    TBL     v3.16b, {v27.16b}, v3.16b
    TBL     v2.16b, {v27.16b}, v2.16b
    //out38 = c38 [0-2]
    STP     q0, q1, [x0]
    STP     q9, q10, [x0, #16*2]
    STP     q2, q3, [x0, #16*4]
    STP     q11, q12, [x0, #16*6]
    ret