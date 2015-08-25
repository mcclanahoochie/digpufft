

**DiGPUFFT** (pronounced "dig-puffed") is a GPU-enhanced fork of [P3DFFT](http://code.google.com/p/p3dfft/).

DiGPUFFT adds CUFFT support inside of P3DFFT, for GPU-accelerated 3D FFT computations. It has only been tested with P3DFFT 2.4 and CUFFT from CUDA Toolkit 3.2.

For a related paper, see:
  * Kenneth Czechowski, Chris McClanahan, Casey Battaglino, Kartik Iyer, P.-K. Yeung, and Richard Vuduc. On the communication complexity of 3D FFTs and its implications for exascale. In _Proceedings of the ACM International Conference on Supercomputing ([ICS](http://ics-conference.org/))_, San Servolo Island, Venice, Italy, June 2012. (_to appear_) [Download PDF preprint](http://vuduc.org/pubs/czechowski2012-ics-xfft.pdf)