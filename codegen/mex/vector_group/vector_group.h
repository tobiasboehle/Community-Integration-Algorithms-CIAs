/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * vector_group.h
 *
 * Code generation for function 'vector_group'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "vector_group_types.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void vector_group(const emlrtStack *sp, const emxArray_real_T *c, real_T N,
                  const emxArray_real_T *col, emxArray_real_T *vp);

/* End of code generation (vector_group.h) */
