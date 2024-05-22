---
layout: page
title: Scaling the Finite Element Method to Small Problems with Dense Linear Solvers
description: my work at NYU's Geometric Computing Lab
img: assets/img/publication_preview/dense-assembly-preview.png
importance: 1
category: academic
permalink: /assets/pdf/dense-assembly-poster.pdf
related_publications: false
---

The finite element method (FEM) is a numerical algorithm for solving boundary-value partial differential equations by splitting the domain into basis elements represented by a mesh, solving the equation for each element, and interpolating. FEM uses linear algebra, typically accelerated by GPUs due to their parallel processing ability. Due to the large number of elements and relatively low number of inter-element interactions, software implementing the FEM normally uses sparse matrix data structures, which use less memory and perform operations faster on large matrices containing mostly zeros. However, since GPUs are optimized for dense matrix multiplication, using a sparse matrix data structure may be slower than typical dense matrices for problems of small size due to the added overhead and non-uniform element storage.

This experiment used dense matrix data structures to approximate solutions to the discrete Laplace operator, which is used to calculate optimal mesh deformations with As Rigid As Possible (ARAP) energy, with the finite element method. Although assembly of the discrete Laplace matrix took significantly less time for square matrices with fewer than 1000 rows, and solving the matrix equation also had a significant speedup, the lost time from allocating and zeroing space for a dense matrix offset both of these gains. Future gains in performance may be found by rewriting the assembly routine to run on a GPU.
