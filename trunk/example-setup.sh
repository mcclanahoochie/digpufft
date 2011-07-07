########
#
# Example digpufft Setup
#   -This particular setup file is designed for the Keeneland cluster
#
#######


export DIGPUFFT_ROOT=~/digpufft_newroot/ 
cd $DIGPUFFT_ROOT


#
# Get digpufft
#
svn checkout http://digpufft.googlecode.com/svn/trunk/ digpufft-read-only


#
# Get and unpackage p3dfft 
#
wget http://p3dfft.googlecode.com/files/p3dfft-2.4.tar.gz
tar xzvf p3dfft-2.4.tar.gz
mv p3dfft-2.4 p3dfft-2.4-orig


#
# Load dependencies (Keeneland specific)
#
module load intel/2011.3.174
module load openmpi/1.5.1-intel
module load fftw/3.2.1
module load cuda/3.2

export FFTW_HOME=/sw/keeneland/fftw/3.2.1/centos5.4_gnu4.1.2_fPIC/ #This should be placed in ~/.bashrc


#
# Complile p3dfft without digpufft (just to make sure p3dfft is working properly)
#
cd $DIGPUFFT_ROOT/p3dfft-2.4-orig/
./configure --enable-intel --enable-fftw --with-fftw=$FFTW_HOME FCFLAGS="-O3 -xW -132 -fpp" CFLAGS="-O3 -xW" LDFLAGS="-lmpi_f90 -lmpi_f77 -limf" FC=mpif90 --enable-single --enable-stride1 CC=mpicc
make

#Add Sample files for testing
echo "8,8,8,2,1" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.3
echo "64,64,64,2,13" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.64
echo "128,128,128,2,13" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.128
echo "512,512,512,2,11" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.512
echo "1024,1024,1024,2,9" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.1024
echo "2048,2048,2048,2,7" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.2048
echo "4096,4096,4096,2,10" > $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/fort.4096


#test p3dfft
#cd $DIGPUFFT_ROOT/p3dfft-2.4-orig/sample/FORTRAN/ 
#mpirun test_rand_f.x fort.3



#
# Apply digpufft patch
#
cd $DIGPUFFT_ROOT
patch -Np0 < ./digpufft-read-only/digpufft-p3dfft-2.4.patch



#
# Compile p3dfft with digpufft
#
cd $DIGPUFFT_ROOT/p3dfft-2.4-orig/
make clean
./configure --enable-intel --enable-fftw --with-fftw=$FFTW_HOME FCFLAGS="-O3 -xW -132 -fpp" CFLAGS="-O3 -xW" LDFLAGS="-lmpi_f90 -lmpi_f77 -limf" FC=mpif90 --enable-single --enable-stride1 --enable-cuda CC=mpicc
make


