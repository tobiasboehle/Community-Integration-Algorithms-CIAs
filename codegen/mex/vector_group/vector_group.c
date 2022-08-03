/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * vector_group.c
 *
 * Code generation for function 'vector_group'
 *
 */

/* Include files */
#include "vector_group.h"
#include "rt_nonfinite.h"
#include "vector_group_data.h"
#include "vector_group_emxutil.h"
#include "vector_group_types.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtDCInfo emlrtDCI = {
    6,              /* lineNo */
    23,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    1                                          /* checkKind */
};

static emlrtBCInfo emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    6,              /* lineNo */
    23,             /* colNo */
    "vp",           /* aName */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    0                                          /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    6,              /* lineNo */
    37,             /* colNo */
    "c",            /* aName */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    0                                          /* checkKind */
};

static emlrtECInfo emlrtECI = {
    2,              /* nDims */
    6,              /* lineNo */
    20,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtDCInfo b_emlrtDCI = {
    6,              /* lineNo */
    8,              /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    1                                          /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    6,              /* lineNo */
    8,              /* colNo */
    "vp",           /* aName */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    0                                          /* checkKind */
};

static emlrtECInfo b_emlrtECI = {
    -1,             /* nDims */
    6,              /* lineNo */
    5,              /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtDCInfo c_emlrtDCI = {
    4,              /* lineNo */
    12,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    1                                          /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = {
    4,              /* lineNo */
    12,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    4                                          /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = {
    4,              /* lineNo */
    1,              /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    1                                          /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    6,              /* lineNo */
    27,             /* colNo */
    "col",          /* aName */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    0                                          /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    6,              /* lineNo */
    12,             /* colNo */
    "col",          /* aName */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m", /* pName */
    0                                          /* checkKind */
};

static emlrtRTEInfo emlrtRTEI = {
    4,              /* lineNo */
    1,              /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtRTEInfo b_emlrtRTEI = {
    6,              /* lineNo */
    35,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtRTEInfo c_emlrtRTEI = {
    6,              /* lineNo */
    20,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtRTEInfo d_emlrtRTEI = {
    1,              /* lineNo */
    15,             /* colNo */
    "vector_group", /* fName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pName */
};

static emlrtRSInfo emlrtRSI = {
    6,              /* lineNo */
    "vector_group", /* fcnName */
    "C:\\Users\\Tobias\\Nextcloud\\Projekte\\Community Integration "
    "Algorithms\\Simulations\\vector_group.m" /* pathName */
};

/* Function Declarations */
static void binary_expand_op(const emlrtStack *sp, emxArray_real_T *r1,
                             const emxArray_real_T *vp,
                             const emxArray_real_T *col, int32_T j);

/* Function Definitions */
static void binary_expand_op(const emlrtStack *sp, emxArray_real_T *r1,
                             const emxArray_real_T *vp,
                             const emxArray_real_T *col, int32_T j)
{
  emxArray_real_T *b_vp;
  const real_T *col_data;
  const real_T *vp_data;
  real_T *b_vp_data;
  real_T *r;
  int32_T b_col;
  int32_T i;
  int32_T loop_ub;
  int32_T stride_0_1;
  int32_T stride_1_1;
  col_data = col->data;
  vp_data = vp->data;
  r = r1->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  emxInit_real_T(sp, &b_vp, 2, &c_emlrtRTEI);
  b_col = (int32_T)col_data[j];
  i = vp->size[1];
  stride_0_1 = b_vp->size[0] * b_vp->size[1];
  b_vp->size[0] = 1;
  if (r1->size[1] == 1) {
    b_vp->size[1] = i;
  } else {
    b_vp->size[1] = r1->size[1];
  }
  emxEnsureCapacity_real_T(sp, b_vp, stride_0_1, &c_emlrtRTEI);
  b_vp_data = b_vp->data;
  stride_0_1 = (i != 1);
  stride_1_1 = (r1->size[1] != 1);
  if (r1->size[1] == 1) {
    loop_ub = i;
  } else {
    loop_ub = r1->size[1];
  }
  for (i = 0; i < loop_ub; i++) {
    b_vp_data[i] = vp_data[(b_col + vp->size[0] * (i * stride_0_1)) - 1] +
                   r[i * stride_1_1];
  }
  i = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = b_vp->size[1];
  emxEnsureCapacity_real_T(sp, r1, i, &c_emlrtRTEI);
  r = r1->data;
  loop_ub = b_vp->size[1];
  for (i = 0; i < loop_ub; i++) {
    r[i] = b_vp_data[i];
  }
  emxFree_real_T(sp, &b_vp);
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

void vector_group(const emlrtStack *sp, const emxArray_real_T *c, real_T N,
                  const emxArray_real_T *col, emxArray_real_T *vp)
{
  emlrtStack st;
  emxArray_real_T *r;
  const real_T *c_data;
  const real_T *col_data;
  real_T d;
  real_T *r1;
  real_T *vp_data;
  int32_T iv[2];
  int32_T b_loop_ub;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T j;
  int32_T loop_ub;
  st.prev = sp;
  st.tls = sp->tls;
  col_data = col->data;
  c_data = c->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  if (!(N >= 0.0)) {
    emlrtNonNegativeCheckR2012b(N, &d_emlrtDCI, (emlrtCTX)sp);
  }
  d = (int32_T)muDoubleScalarFloor(N);
  if (N != d) {
    emlrtIntegerCheckR2012b(N, &c_emlrtDCI, (emlrtCTX)sp);
  }
  i = vp->size[0] * vp->size[1];
  vp->size[0] = (int32_T)N;
  vp->size[1] = c->size[1];
  emxEnsureCapacity_real_T(sp, vp, i, &emlrtRTEI);
  vp_data = vp->data;
  if (N != d) {
    emlrtIntegerCheckR2012b(N, &e_emlrtDCI, (emlrtCTX)sp);
  }
  loop_ub = (int32_T)N * c->size[1];
  for (i = 0; i < loop_ub; i++) {
    vp_data[i] = 0.0;
  }
  i = col->size[0];
  if (0 <= col->size[0] - 1) {
    i1 = c->size[1];
    b_loop_ub = c->size[1];
    iv[0] = 1;
  }
  emxInit_real_T(sp, &r, 2, &d_emlrtRTEI);
  for (j = 0; j < i; j++) {
    if (j + 1 > col->size[0]) {
      emlrtDynamicBoundsCheckR2012b(j + 1, 1, col->size[0], &d_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    d = col_data[j];
    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &emlrtDCI, (emlrtCTX)sp);
    }
    if (((int32_T)d < 1) || ((int32_T)d > vp->size[0])) {
      emlrtDynamicBoundsCheckR2012b((int32_T)d, 1, vp->size[0], &emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (j + 1 > c->size[0]) {
      emlrtDynamicBoundsCheckR2012b(j + 1, 1, c->size[0], &b_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    i2 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = i1;
    emxEnsureCapacity_real_T(sp, r, i2, &b_emlrtRTEI);
    r1 = r->data;
    for (i2 = 0; i2 < b_loop_ub; i2++) {
      r1[i2] = c_data[j + c->size[0] * i2] / N;
    }
    loop_ub = vp->size[1];
    if ((vp->size[1] != r->size[1]) &&
        ((vp->size[1] != 1) && (r->size[1] != 1))) {
      emlrtDimSizeImpxCheckR2021b(vp->size[1], r->size[1], &emlrtECI,
                                  (emlrtCTX)sp);
    }
    if (j + 1 > col->size[0]) {
      emlrtDynamicBoundsCheckR2012b(j + 1, 1, col->size[0], &e_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    d = col_data[j];
    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &b_emlrtDCI, (emlrtCTX)sp);
    }
    if (((int32_T)d < 1) || ((int32_T)d > vp->size[0])) {
      emlrtDynamicBoundsCheckR2012b((int32_T)d, 1, vp->size[0], &c_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (vp->size[1] == r->size[1]) {
      i2 = r->size[0] * r->size[1];
      r->size[0] = 1;
      r->size[1] = vp->size[1];
      emxEnsureCapacity_real_T(sp, r, i2, &c_emlrtRTEI);
      r1 = r->data;
      for (i2 = 0; i2 < loop_ub; i2++) {
        r1[i2] += vp_data[((int32_T)col_data[j] + vp->size[0] * i2) - 1];
      }
    } else {
      st.site = &emlrtRSI;
      binary_expand_op(&st, r, vp, col, j);
      r1 = r->data;
    }
    iv[1] = vp->size[1];
    emlrtSubAssignSizeCheckR2012b(&iv[0], 2, &r->size[0], 2, &b_emlrtECI,
                                  (emlrtCTX)sp);
    loop_ub = r->size[1];
    for (i2 = 0; i2 < loop_ub; i2++) {
      vp_data[((int32_T)col_data[j] + vp->size[0] * i2) - 1] = r1[i2];
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtCTX)sp);
    }
  }
  emxFree_real_T(sp, &r);
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

/* End of code generation (vector_group.c) */
