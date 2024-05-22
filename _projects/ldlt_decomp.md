---
layout: page
title: Implementing and Benchmarking a Parallel LDLT Factorization with SYCL
description: my work at the Flatiron Institute
img: assets/img/publication_preview/ldlt-preview.png
importance: 1
category: academic
permalink: /assets/pdf/ldlt-sycl-poster.pdf
related_publications: false
---

Numerical linear algebra has applications in the fields of machine learning, geometric processing, and physical simulations. To solve a system of linear equations numerically, factorizing a matrix with methods such as $LDU$ and $$QR$$ is preferred for accuracy and speed. Once factorized into $$LDU$$ or $$LDL^T$$, solving a system of linear equations only takes $$O(n^2)$$ additional floating point operations (FLOPs) for forward and backward substitution. For symmetric matrices, the $$LDL^T$$ decomposition may be preferred over the Cholesky, or $$LL^T$$, decomposition because it requires no square root operations, and therefore works for matrices that have negative eigenvalues.

Most large systems of linear equations use sparse matrix storage and matrix algorithms. These sparse algorithms are based on, and are often implemented with, underlying dense matrix algorithms. GPUs are optimized for dense linear algebra, especially matrix-matrix operations. The goal of this study is to measure the performance of the SYCL language, a cross-platform GPU programming language that is a superset of C++, against the platform-specific implementations provided by NVIDIA's cuSolverDN. Here, we focus on the $$LDL^T$$ decomposition for a symmetric matrix $$A$$ with no non-singular principal minors, or "upper-left square corners".

The parallel block $$LDL^T$$ algorithm using a packed data structure, called ssptrf() in LAPACK, was implemented in both OpenMP, a CPU parallelization library running on an Intel Xeon with 32 threads allocated, and SYCL, a cross-platform open standard GPU library, running on an NVIDIA H100 GPU. Even for small matrices, the GPU version vastly outperforms the CPU version. By the time the matrix is of size $$40000\times40000$$, a 100-fold speedup by the SYCL implementation over OpenMP is observed, achieving speeds of more than 3 TeraFLOPS (floating point operations per second). Starting at $$mn=49152$$, "jaggedness" in the performance graph is observed. This may be caused by the GPU cores being fully occupied. Possible future directions include adding a pivoting routine to the SYCL version for increased numerical stability, and implementing more packed symmetric LAPACK routines in SYCL for cross-platform support.
