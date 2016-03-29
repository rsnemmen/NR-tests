c----------------------------------------------------------------------
c evolution and other numerical routines for wave
c----------------------------------------------------------------------

c----------------------------------------------------------------------
c phi_evo() performs 1 evolution time step of the wave equation,
c solving for the field at time np1, with Dirichlet boundary conditions
c
c box(phi) = 0
c
c ==>
c
c phi,t,t - phi,x,x = 0
c
c ==>
c
c (phi_np1(i)-2*phi_n(i)+phi_nm1(i))/dt^2=
c (phi_n(i+1)-2*phi_n(i)+phi_n(i-1))/dx^2 
c
c ==>
c
c phi_np1(i) = 2*phi_n(i) - phi_nm1(i) + 
c dt^2*((phi_n(i+1)-2*phi_n(i)+phi_n(i-1))/dx^2)
c----------------------------------------------------------------------
        subroutine phi_evo(phi_np1,phi_n,phi_nm1,bbox,dt,Nx)
        implicit none
        integer Nx
        real*8 phi_np1(Nx),phi_n(Nx),phi_nm1(Nx)
        real*8 bbox(2),dt

        integer i
        real*8 dx

        dx=(bbox(2)-bbox(1))/(Nx-1)

        do i=2,Nx-1
           phi_np1(i)=2*phi_n(i)-phi_nm1(i)+dt**2*
     &        (phi_n(i+1)-2*phi_n(i)+phi_n(i-1))/dx**2
           write(*,*) phi_np1(i),real(i)/real(Nx)
        end do

        return
        end

c----------------------------------------------------------------------
c initializes f with a gaussian :
c
c f = A * exp (- (x-x0)^2/delta^2) 
c----------------------------------------------------------------------
        subroutine gauss_id(f,A,delta,x0,bbox,Nx)
        implicit none
        integer Nx
        real*8 f(Nx),bbox(2)
        real*8 A,r0,delta,x0

        integer i
        real*8 x,dx

        dx=(bbox(2)-bbox(1))/(Nx-1)

        do i=1,Nx
           x=(i-1)*dx+bbox(1)
           f(i)=A*exp(-((x-x0)/delta)**2) 
        end do

        return
        end
