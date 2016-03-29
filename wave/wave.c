//=============================================================================
// application interface functions for wave example
//=============================================================================
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sdf.h>
#include "wave.h"

//=============================================================================

int main(int argc, char **argv)
{
   //==========================================================================
   // id parameters (time symmetric gaussian)
   //==========================================================================
   char *pfile;
   char *tag,phi_fname[256];
   double phi_amp,phi_delta,phi_x0;

   //==========================================================================
   // grid data, three time levels
   //==========================================================================
   double *phi_n,*phi_np1,*phi_nm1,*tmp;

   //==========================================================================
   // grid properties
   //==========================================================================
   int Nx,Nt;
   double bbox[2],dx,dt,lambda,t;

   //==========================================================================
   // other local vars
   //==========================================================================
   int i;

   if (argc!=2)
   {
      printf("Usage:\n\n%s parameter_file_name\n\n",argv[0]);
      exit(-1);
   }
   pfile=argv[1];

   
   //==========================================================================
   // first, initialize with default parameters
   //==========================================================================
   Nx=129;
   Nt=129;
   bbox[0]=-1;
   bbox[1]=1;
   lambda=0.5;
   phi_amp=1.0;
   phi_delta=0.1;
   phi_x0=0.0;
   tag=0;

   //==========================================================================
   // read input parameters using routines from sdf library
   //==========================================================================
   get_int_param(pfile,"Nx",&Nx,1);  
   get_int_param(pfile,"Nt",&Nt,1);  
   get_real_param(pfile,"bbox",bbox,2);  
   get_real_param(pfile,"lambda",&lambda,1);  
   get_real_param(pfile,"phi_amp",&phi_amp,1);  
   get_real_param(pfile,"phi_delta",&phi_delta,1);  
   get_real_param(pfile,"phi_x0",&phi_x0,1);  
   get_str_param(pfile,"tag",&tag,1);

   sprintf(phi_fname,"phi_n%s",tag);

   //==========================================================================
   // initialize some other numbers
   //==========================================================================
   dx=(bbox[1]-bbox[0])/(Nx-1);
   dt=lambda*dx;
   
   //=============================================================================
   // allocate memory
   //=============================================================================
   if (!((phi_nm1=(double *)malloc(sizeof(double)*Nx)) &&
         (phi_n=(double *)malloc(sizeof(double)*Nx)) &&
         (phi_np1=(double *)malloc(sizeof(double)*Nx))))
   {
      printf("\nError : failed to allocate grid arrays\n");
      exit(-1);
   }

   //=============================================================================
   // initial data. The following is only time-symmetric to first order in dt
   // at t=0 with this 3 time-level schame (can use equations of 
   // motion set past time level if 2nd order accurate implementation of this
   // condition is desired)
   //=============================================================================

   gauss_id_(phi_n,&phi_amp,&phi_delta,&phi_x0,bbox,&Nx);
   for (i=0; i<Nx; i++) {phi_nm1[i]=phi_n[i]; phi_np1[i]=0;}

   printf("%s\n\nIntegrating the wave equation %i time steps ... ",argv[0],Nt);

   //=============================================================================
   // Now evolve
   //=============================================================================
   for (t=0, i=0; i<Nt; i++, t+=dt)
   {
      phi_evo_(phi_np1,phi_n,phi_nm1,bbox,&dt,&Nx);
      gft_out_bbox(phi_fname,t,&Nx,1,bbox,phi_n);
      //==========================================================================
      // cycle time levels
      //==========================================================================
      tmp=phi_nm1; phi_nm1=phi_n; phi_n=phi_np1; phi_np1=tmp;
   }
   gft_out_bbox(phi_fname,t,&Nx,1,bbox,phi_n); // last time step
   printf("done\n");
}
