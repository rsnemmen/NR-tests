! Creates a Fortran binary file from an array
!
! Usage:
! 	writebin(10,data,"data")
!
! where:
! - 10 : index corresponding to a specific time-slice
! - data : array to be saved
! - "data" : base-filename, in this case the actual file will
!   be "data.10"

SUBROUTINE WRITEBIN(I,x,FNAME)
IMPLICIT NONE
INTEGER :: I
REAL :: x(*)
CHARACTER :: FNAME*(*), istr*5	

! converts integer to string
write(istr, '(i10)' ) I
! joins the two strings
fname=fname // istr

OPEN(UNIT=1000,FILE=FNAME,STATUS='REPLACE',form='unformatted')
write(1000) x
CLOSE(1000)
END SUBROUTINE WRITEBIN
