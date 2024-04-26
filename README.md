# Jumping4Bernstein-YangInversion

## Overview
This repository contains the implementation and resources related to the paper titled **Jumping for Bernstein-Yang Inversion**.

Authors:
- Li-Jie Jian `jcuyo613@gmail.com`
- Ting-Yuan Wang `deanwang88528@gmail.com`
- Bo-Yin Yang `byyang@iis.sinica.edu.tw`
- Ming-Shing Chen `mschen@crypto.tw`

## Structure
- `cycles`: Code for accessing cycle counters.
- `enable_ccr`: The prerequisites regarding accessing cycle counters. Please refer to the details provided [here](https://github.com/mupq/pqax).
- `fake-supercop`: Basice definition for crypto core
- `inv3sntrup761-neon`: Implementation of inv3sntrup761
- `invsntrup761-neon`: Implementation of invsntrup761
- `invsntrup653-neon`: Implementation of invsntrup653

## Benchmark
For Polynomial Multiplication :
```
make clean; make polymul
```
For Polynomial Inversion :
```
make clean; make recip
```





