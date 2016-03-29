/*============================================================================= */
/* Prototypes for fortran functions called                                      */
/*============================================================================= */

void gauss_id_(double *f, double *A, double *delta, double *x0, double *bbox, int *Nx);
void phi_evo_(double *phi_np1, double *phi_n, double *phi_nm1, double *bbox, double *dt, int *Nx);
