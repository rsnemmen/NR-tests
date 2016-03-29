	program main

!load modules of things needed
		
	use m_initial
	use m_evolve
	use m_pars 
	
	implicit none

	
!define variables, of an undetermined size yet
!let's have u(1) = a; u(2) = b; u(3) = c;
! u(4) = ka; u(5) = k(b); u(6) = k(c)
! u(7) = da; u(8) = db; u(9) = dc
! x radial grid

	real*8, dimension(:,:), allocatable :: unew, uold
	real*8, dimension(:), allocatable :: x
	
!variables for the rest
	real*8 :: dx, dt, Rmax, time
	integer :: i,j, gft_out_full,gft_out_brief, ret
	
	integer :: m1, m2, m3

!read pars
	call readpars
   	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		
!allocate memmory
	allocate(uold(9,Nx),unew(9,nx),x(nx))	
!define grid
	dx = (-Rmin+Rout)/(Nx-1)
	dt = cfl * dx
	do i=1, nx
	x(i) = Rmin + (i-1)*dx
	end do

	m1 = int((40-Rmin)/dx) + 1
        m2 = int((70-Rmin)/dx) + 1
        m3 = int((100-Rmin)/dx) + 1

!intialize
	time = 0.0
	call initial(uold,x,Nx)
	
		
!time loop	
	do i = 1, Nt
	
	call evolve(unew,uold,dx,dt,x)
	
!update fileds and time	
	uold = unew   	
	time = time + dt
	
!every now and then do some output
!RN: will replace SDF file format with a more friendly, common file
!format
	  if(mod(i,freq).eq.0) then
	  !will call here for output
	  	ret = gft_out_full('phi',time, nx, 'x', 1, x, uold(1,:))
        ret = gft_out_full('g',time, nx, 'x', 1, x, uold(2,:))
        ret = gft_out_full('f',time, nx, 'x', 1, x, uold(3,:))
	  end if

	
	end do
	
	end
